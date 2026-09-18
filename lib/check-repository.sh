```bash
#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Check Repository
# ------------------------------------------------------------------------------
# /lib/check-repository.sh

check_local()
{
    local target_dir="$1"

    mkdir -p -- "$target_dir"

    if [[ ! -d "$target_dir/.git" ]]; then
        git -C "$target_dir" init >/dev/null
    fi
}

check_remote()
{
    local target_dir="$1"
    local repository
    local repo_url

    repository="$(basename "$target_dir")"
    repository="${repository#.}"

    repo_url="https://github.com/WillemAchterhof/${repository}.git"

    if ! git -C "$target_dir" remote get-url origin >/dev/null 2>&1; then
        git -C "$target_dir" remote add origin "$repo_url"
    else
        git -C "$target_dir" remote set-url origin "$repo_url"
    fi

    git -C "$target_dir" fetch origin >/dev/null 2>&1
}

sync_repo()
{
    local target_dir="$1"
    local policy="${2:-normal}"
    local branch
    local local_commit
    local remote_commit

    branch="$(
        git -C "$target_dir" remote show origin |
        awk '/HEAD branch/ {print $NF}'
    )"

    [[ -n "$branch" ]] \
        || {
            printf "ERROR: Unable to determine remote branch\n"
            return 1
        }

    local_commit="$(git -C "$target_dir" rev-parse HEAD 2>/dev/null || true)"
    remote_commit="$(git -C "$target_dir" rev-parse "origin/$branch")"

    if [[ "$local_commit" == "$remote_commit" ]]; then
        return 0
    fi

    if [[ "$policy" == "force-remote" ]]; then
        git -C "$target_dir" checkout -B "$branch" "origin/$branch" >/dev/null 2>&1 \
            || {
                printf "ERROR: Unable to checkout remote branch\n"
                return 1
            }

        git -C "$target_dir" reset --hard "origin/$branch" >/dev/null 2>&1 \
            || {
                printf "ERROR: Unable to reset repository\n"
                return 1
            }

        git -C "$target_dir" clean -fd >/dev/null 2>&1 \
            || {
                printf "ERROR: Unable to clean repository\n"
                return 1
            }

        return 0
    fi

    printf "WARNING: Repository differs from remote\n"
}

check_repository()
{
    local target_dir="${1:?ERROR: repository path required}"
    local policy="${2:-normal}"

    check_local "$target_dir" || return 1
    check_remote "$target_dir" || return 1
    sync_repo "$target_dir" "$policy" || return 1
}
```
