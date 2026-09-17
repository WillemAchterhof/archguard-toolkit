#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Backup Copy
# ------------------------------------------------------------------------------
# /lib/backup-copy.sh

backup_copy()
{
    local config_file="$1"
    local target_root="$2"
    local backup
    local source
    local target

    source "$config_file"

    for backup in "${BACKUP_CONFIGS[@]}"; do
        IFS='|' read -r source target <<< "$backup"

        [[ -e "$source" ]] || {
            printf "WARNING: Backup source not found: %s\n" "$source"
            continue
        }

        target="$target_root/$target"

        mkdir -p -- "$(dirname "$target")"
        cp -a -- "$source" "$target"

        printf "Copied: %s -> %s\n" "$source" "$target"
    done
}
