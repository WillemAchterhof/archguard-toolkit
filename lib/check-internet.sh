#!/usr/bin/env bash
# ==============================================================================
#  ArchGuard Toolkit — Internet Check
# ==============================================================================
#  lib/check-internet.sh
# ==============================================================================

check_internet()
{
    timeout 5 ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1 \
        || {
            printf "ERROR: No internet connection"
            return 1
        }

    printf "Internet connection confirmed"
}
