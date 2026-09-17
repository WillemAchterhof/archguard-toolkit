#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# ArchGuard Configs — Entry Point
# ------------------------------------------------------------------------------
# backup-configs.sh
# ------------------------------------------------------------------------------

set -Eeuo pipefail

# Dependencies
source 


backup_configs()
{
    local commit_message

    check_internet
    check_repository "archguard-configs" "$BACKUP_ROOT"

    commit_message="$(read_commit_message)"

    bash "$BACKUP_ROOT/backup-run.sh" "$commit_message"

    printf "Config backup completed"
}

backup_configs
