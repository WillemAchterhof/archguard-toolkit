#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# ArchGuard Post-Install
# ------------------------------------------------------------------------------
# /root-run.sh

set -Eeuo pipefail

# Variables
ROOT_TOOLKIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_LIB="$ROOT_TOOLKIT/lib"
ROOT_BACKUP="$ROOT_TOOLKIT/backup-configs"
ROOT_MENU="$ROOT_TOOLKIT/menu"
ROOT_TPM="$ROOT_TOOLKIT/tpm-management"

# Module Entry Points
source "$ROOT_MENU/menu-run.sh"
source "$ROOT_BACKUP/backup-configs.sh"
source "$ROOT_TPM/enroll-tpm.sh"


# Run

menu_render

while true; do
    key=""

    if ! read -rsn1 key; then
        continue
    fi

    case "$key" in
        z)
            break
            ;;
        *)
            menu_handle_input "$key"
            ;;
    esac

    menu_render
done
