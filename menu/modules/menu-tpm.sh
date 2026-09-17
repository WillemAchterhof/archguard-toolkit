#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# TPM Management
# ------------------------------------------------------------------------------
# /menu/modules/menu-tpm.sh

enroll_tpm()
{
    sudo bash "$ROOT_TOOLS/tpm-management/enroll-tpm.sh"
}

MENU_OPTIONS[a]="enroll_tpm|Enroll TPM|"
MENU_KEY="a"