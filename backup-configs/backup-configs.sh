```bash
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
    local repository="$ROOT_TOOLKIT/archguard-configs"
    local config_file="$ROOT_BACKUP/backup-configs.env"
    local commit_message

    check_repository \
        "$repository" \
        "force-remote"

    backup_copy \
        "$config_file" \
        "$repository"

    if [[ -z "$(git -C "$repository" status --porcelain)" ]]; then
        MENU_OPTIONS[b]="backup_configs|Backup Configs|No updates in configs."
        return 0
    fi

    commit_message="$(read_commit_message)"

    git_push \
        "$repository" \
        "$commit_message"

    MENU_OPTIONS[b]="backup_configs|Backup Configs|New config files uploaded."
}
```
