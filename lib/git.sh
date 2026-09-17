#!/usr/bin/env bash
# ------------------------------------------------------------------------------
# Git 
# ------------------------------------------------------------------------------
# /lib/git.sh

read_commit_message()
{
    local message

    read -rp "Commit message: " message

    [[ -n "$message" ]] \
        || {
            printf "ERROR: Commit message cannot be empty\n"
            return 1
        }

    printf '%s\n' "$message"
}

git_push()
{
    local commit_message="${1:-}"

    [[ -n "$commit_message" ]] \
        || {
            printf "ERROR: Commit message cannot be empty\n"
            return 1
        }

    git add . &&
    git commit -m "$commit_message" &&
    git push -u origin "$(git branch --show-current)"
}
