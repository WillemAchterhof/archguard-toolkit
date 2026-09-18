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
    local repository="$1"
    local commit_message="${2:-}"

    [[ -d "$repository/.git" ]] \
        || {
            printf "ERROR: Not a git repository: %s\n" "$repository"
            return 1
        }

    [[ -n "$commit_message" ]] \
        || {
            printf "ERROR: Commit message cannot be empty\n"
            return 1
        }

    git -C "$repository" add . &&
    git -C "$repository" commit -m "$commit_message" &&
    git -C "$repository" push -u origin "$(git -C "$repository" branch --show-current)"
}
