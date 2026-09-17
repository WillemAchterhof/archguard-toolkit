#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# TPM Management
# ------------------------------------------------------------------------------
# /menu/modules/menu-tpm.sh

menu_enroll_tpm()
{
    sudo bash -c '
        source "$1"
        enroll_tpm
    ' _ "$(dirname "$ROOT_MENU")/tpm-management/enroll-tpm.sh"
}

MENU_OPTIONS[a]="menu_enroll_tpm|Enroll TPM|"
MENU_KEY="a"
