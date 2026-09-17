#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# ArchGuard Configs — Entry Point
# ------------------------------------------------------------------------------
# backup-configs.sh
# ------------------------------------------------------------------------------

set -Eeuo pipefail

BACKUP_ROOT="$SCRIPT_ROOT/backup"

backup_configs()
{
    local commit_message

    log_tools "Starting config backup"

    check_internet
    check_repository "archguard-configs" "$BACKUP_ROOT"

    commit_message="$(read_commit_message)"

    bash "$BACKUP_ROOT/backup-run.sh" "$commit_message"

    log_tools "Config backup completed"
}

backup_configs
