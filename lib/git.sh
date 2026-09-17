#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# ArchGuard Tools — Git Functions
# ------------------------------------------------------------------------------
# lib/git.sh
# ------------------------------------------------------------------------------

read_commit_message()
{
    local message

    read -rp "Commit message: " message

    [[ -n "$message" ]] \
        || {
            log_tools "ERROR: Commit message cannot be empty"
            return 1
        }

    printf '%s\n' "$message"
}

git_push()
{
    local commit_message="${1:-}"

    [[ -n "$commit_message" ]] \
        || {
            log_tools "ERROR: Commit message cannot be empty"
            return 1
        }

    git add . &&
    git commit -m "$commit_message" &&
    git push
}
