#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Restore Copy
# ------------------------------------------------------------------------------
# /lib/restore-copy.sh

restore_copy()
{
    local config_file="$1"
    local source_root="$2"
    local backup
    local source
    local target

    source "$config_file"

    for backup in "${BACKUP_CONFIGS[@]}"; do
        IFS='|' read -r target source <<< "$backup"

        source="$source_root/$source"

        [[ -e "$source" ]] || {
            printf "WARNING: Restore source not found: %s\n" "$source"
            continue
        }

        mkdir -p -- "$(dirname "$target")"
        cp -a -- "$source" "$target"

        printf "Restored: %s -> %s\n" "$source" "$target"
    done
}