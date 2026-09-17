#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# TPM Enrollment
# ------------------------------------------------------------------------------
# /tpm-management/enroll-tpm.sh

set -Eeuo pipefail

readonly AG_TPM_PCRS="0+1+2+4+5+7+12"
readonly AG_TPM_PUBKEY="/etc/systemd/tpm2-pcr-public-key-initrd.pem"

log_tpm()
{
    printf '[ArchGuard TPM] %s\n' "$*"
}

get_luks_device()
{
    local device

    device="$(cryptsetup status cryptroot 2>/dev/null \
        | awk '/device:/ {print $2; exit}')"

    [[ -n "$device" ]] \
        || {
            log_tpm "ERROR: Unable to determine LUKS device for cryptroot"
            return 1
        }

    printf '%s\n' "$device"
}

enroll_tpm()
{
    local luks_device

    log_tpm "Starting TPM2 enrollment"

    [[ -f "$AG_TPM_PUBKEY" ]] \
        || {
            log_tpm "ERROR: PCR signing public key not found: $AG_TPM_PUBKEY"
            return 1
        }

    luks_device="$(get_luks_device)"

    log_tpm "LUKS device: $luks_device"
    log_tpm "Raw PCR policy: $AG_TPM_PCRS"
    log_tpm "Signed PCR policy (UKI integrity): $AG_TPM_PUBKEY"
    log_tpm "Enrolling TPM2 with mandatory PIN"
    log_tpm "You will be prompted for the current LUKS passphrase, then the TPM PIN"

    systemd-cryptenroll \
        --tpm2-device=auto \
        --tpm2-with-pin=yes \
        --tpm2-pcrs="$AG_TPM_PCRS" \
        --tpm2-public-key="$AG_TPM_PUBKEY" \
        --tpm2-public-key-pcrs=11 \
        "$luks_device"

    log_tpm "TPM2 enrollment completed"
}