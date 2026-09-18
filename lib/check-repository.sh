#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Check Repository
# ------------------------------------------------------------------------------
# /lib/check-repository.sh

check_local()
{
    local target_dir="$1"

    [[ -d "$target_dir" ]] \
        || {
            printf "ERROR: Local repository does not exist: %s\n" "$target_dir"
            return 1
        }

    [[ -d "$target_dir/.git" ]] \
        || {
            printf "ERROR: Local directory is not a Git repository: %s\n" "$target_dir"
            return 1
        }

    printf "Local repository confirmed: %s\n" "$target_dir"
}

check_remote()
{
    local repository="$1"
    local target_dir="$2"
    local repo_url="https://github.com/WillemAchterhof/${repository}.git"

    cd -- "$target_dir"

    git remote get-url origin >/dev/null 2>&1 \
        || {
            git remote add origin "$repo_url"
        }

    git remote set-url origin "$repo_url"

    git ls-remote origin >/dev/null 2>&1 \
        || {
            printf "ERROR: GitHub repository unavailable: %s\n" "$repo_url"
            return 1
        }

    git fetch origin \
        || {
            printf "ERROR: Unable to fetch repository: %s\n" "$repository"
            return 1
        }

    printf "Remote repository confirmed: %s\n" "$repository"
}

sync_repo()
{
    local target_dir="$1"
    local policy="${2:-normal}"
    local branch
    local local_commit
    local remote_commit

    cd -- "$target_dir"

    branch="$(git remote show origin | awk '/HEAD branch/ {print $NF}')"

    local_commit="$(git rev-parse HEAD 2>/dev/null || true)"
    remote_commit="$(git rev-parse "origin/$branch")"

    if [[ "$local_commit" == "$remote_commit" ]]; then
        printf "Repository is synchronized\n"
        return 0
    fi

    if [[ "$policy" == "force-remote" ]]; then
        printf "Repository differs from remote, synchronizing...\n"

        git reset --hard "origin/$branch" \
            || {
                printf "ERROR: Unable to reset repository\n"
                return 1
            }

        git clean -fd \
            || {
                printf "ERROR: Unable to clean repository\n"
                return 1
            }

        printf "Repository synchronized with remote\n"
        return 0
    fi

    printf "WARNING: Repository differs from remote\n"
}

check_repository()
{
    local repository="${1:?ERROR: repository name required}"
    local target_dir="${2:?ERROR: target directory required}"
    local policy="${3:-normal}"

    check_local "$target_dir" || return 1
    check_remote "$repository" "$target_dir" || return 1
    sync_repo "$target_dir" "$policy" || return 1
}
