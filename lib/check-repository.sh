#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Check Repository
# ------------------------------------------------------------------------------
# /lib/check-repository.sh

check_repository()
{
    local repository="${1:?ERROR: repository name required}"
    local target_dir="${2:?ERROR: target directory required}"
    local repo_url="https://github.com/WillemAchterhof/${repository}.git"

    mkdir -p -- "$target_dir"
    cd -- "$target_dir"

    if [[ ! -d .git ]]; then
        printf "Repository not initialized, initializing...\n"

        git init
        git remote add origin "$repo_url"
    fi

    git ls-remote origin >/dev/null 2>&1 \
        || {
            printf "ERROR: GitHub repository unavailable: %s\n" "$repo_url"
            return 1
        }

    printf "Repository access confirmed: %s\n" "$repository"
}
