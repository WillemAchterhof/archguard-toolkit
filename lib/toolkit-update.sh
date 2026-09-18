#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Toolkit Update
# ------------------------------------------------------------------------------
# /lib/toolkit-update.sh

toolkit_local_commit()
{
    git -C "$ROOT_TOOLKIT" rev-parse HEAD
}

toolkit_remote_commit()
{
    git ls-remote \
        https://github.com/WillemAchterhof/archguard-toolkit.git \
        refs/heads/main |
        awk '{print $1}'
}

toolkit_update_needed()
{
    local local_commit="$1"
    local remote_commit="$2"

    [[ "$local_commit" != "$remote_commit" ]]
}

toolkit_download()
{
    local target_dir="$1"

    git clone \
        --branch main \
        --depth 1 \
        https://github.com/WillemAchterhof/archguard-toolkit.git \
        "$target_dir"
}

toolkit_install()
{
    local source_dir="$1"

    rm -rf -- \
        "$ROOT_TOOLKIT"/* \
        "$ROOT_TOOLKIT"/.[!.]* \
        "$ROOT_TOOLKIT"/..?*

    cp -a -- "$source_dir"/. "$ROOT_TOOLKIT"/
}

toolkit_restart()
{
    exec "$ROOT_TOOLKIT/archguard-toolkit.sh"
}

toolkit_update()
{
    local local_commit
    local remote_commit
    local temp_dir

    local_commit="$(toolkit_local_commit)"
    remote_commit="$(toolkit_remote_commit)"

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

    toolkit_download "$temp_dir" || {
        rm -rf -- "$temp_dir"
        return 1
    }

    toolkit_install "$temp_dir"
    rm -rf -- "$temp_dir"

    printf "Toolkit updated\n"

    toolkit_restart
}
