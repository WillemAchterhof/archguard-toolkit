#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Apply Updates
# ------------------------------------------------------------------------------
# /lib/apply-updates.sh

source "$ROOT_LIB/check-repository.sh"
source "$ROOT_LIB/toolkit-update.sh"

apply_updates()
{
    check_repository \
        "$ROOT_BACKUP/.archguard-configs" \
        "force-remote"

    # toolkit_update
}
