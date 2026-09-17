#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Backup Copy
# ------------------------------------------------------------------------------
# /Tools/Backup/backup-copy.sh

backup_copy()
{
    local source
    local target

    for source in "${BACKUP_CONFIGS[@]}"; do
        [[ -e "$source" ]] || {
            printf "WARNING: Backup source not found: %s\n" "$source"
            continue
        }

        target="$ROOT_BACKUP${source#$HOME}"

        mkdir -p -- "$(dirname "$target")"

        cp -a -- "$source" "$target"

        printf "Copied: %s\n" "$source"
    done
}
