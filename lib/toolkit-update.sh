toolkit_update()
{
    local local_commit
    local remote_commit
    local temp_dir

    printf "Checking toolkit update...\n"

    local_commit="$(toolkit_local_commit)"
    printf "Local commit:  %s\n" "${local_commit:-none}"

    remote_commit="$(toolkit_remote_commit)"
    printf "Remote commit: %s\n" "${remote_commit:-none}"

    [[ -n "$remote_commit" ]] \
        || {
            printf "ERROR: Unable to check toolkit update\n"
            return 1
        }

    if ! toolkit_update_needed "$local_commit" "$remote_commit"; then
        printf "Toolkit is up to date\n"
        return 0
    fi

    printf "Toolkit update available\n"

    temp_dir="$(mktemp -d)"
    printf "Temporary directory: %s\n" "$temp_dir"

    toolkit_download "$temp_dir" || {
        printf "ERROR: Toolkit download failed\n"
        rm -rf -- "$temp_dir"
        return 1
    }

    printf "Toolkit downloaded\n"

    toolkit_install "$temp_dir" "$remote_commit"

    rm -rf -- "$temp_dir"

    printf "Toolkit updated\n"

    toolkit_restart
}
