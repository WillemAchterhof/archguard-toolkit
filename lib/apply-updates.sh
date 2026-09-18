#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Apply Updates
# ------------------------------------------------------------------------------
# /lib/apply-updates.sh

source "$ROOT_LIB/check-internet.sh"
source "$ROOT_LIB/check-repository.sh"

apply_updates()
{
    check_internet
    printf "\n"

    check_repository \
        "$ROOT_BACKUP/.archguard-configs" \
        "force-remote"

    printf "ArchGuard configs synchronized\n"
    printf "\n"
}
