#!/usr/bin/env bash
# ==============================================================================
#  ArchGuard Tools — Internet Check
# ==============================================================================
#  lib/check-internet.sh
# ==============================================================================

check_internet()
{
    log_tools "Checking internet connection..."

    timeout 5 ping -c 1 -W 2 1.1.1.1 >/dev/null 2>&1 \
        || {
            log_tools "ERROR: No internet connection"
            return 1
        }

    log_tools "Internet connection confirmed"
}
