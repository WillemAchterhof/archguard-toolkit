#!/usr/bin/env bash
# ==============================================================================
#  ArchGuard Configs — Entry Point
# ==============================================================================
#  /Tools/backup-configs.sh
# ==============================================================================

set -Eeuo pipefail

SCRIPT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_ROOT="$SCRIPT_ROOT/backup"

source "$SCRIPT_ROOT/global-variables-and-functions.sh"

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
