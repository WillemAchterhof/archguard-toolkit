#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# ArchGuard Configs — Entry Point
# ------------------------------------------------------------------------------
# /backup-configs/backup-configs.sh
# ------------------------------------------------------------------------------

set -Eeuo pipefail

# Dependencies
source "$ROOT_LIB/check-internet.sh"
source "$ROOT_LIB/check-repository.sh"
source "$ROOT_LIB/git.sh"
source "$ROOT_LIB/backup-copy.sh"

backup_configs()
{
    local repository="$ROOT_BACKUP/.archguard-configs"
    local commit_message

    check_internet
    printf "\n"

    check_repository \
        "$repository" \
        "force-remote"

    printf "\n"

    backup_copy \
        "$ROOT_BACKUP/backup-configs.env" \
        "$repository"

    printf "\n"

    if [[ -z "$(git -C "$repository" status --porcelain)" ]]; then
        printf "All configs are up to date.\n"
        return 0
    fi

    printf "Config changes detected.\n\n"

    commit_message="$(read_commit_message)"
    printf "\n"

    git_push "$commit_message"
    printf "\n"

    printf "New config files uploaded.\n"
}
