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
    local commit_message

    check_internet
    printf "\n"

    check_repository \
        "archguard-configs" \
        "$ROOT_BACKUP/.archguard-configs"
    printf "\n"

    backup_copy \
        "$ROOT_BACKUP/backup-configs.env" \
        "$ROOT_BACKUP/.archguard-configs"
    printf "\n"

    commit_message="$(read_commit_message)"
    printf "\n"

    git_push "$commit_message"
    printf "\n"

    printf "Config backup completed\n"
}
