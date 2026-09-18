#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# Menu Renderer
# ------------------------------------------------------------------------------
# /menu/menu-render.sh

menu_render()
{
    local option
    local definition
    local function
    local description
    local variable

    clear

    printf "================================================================================\n"
    printf " ArchGuard Toolkit\n"
    printf "================================================================================\n"
    printf "\n"

    for option in "${MENU_ORDER[@]}"; do
        definition="${MENU_OPTIONS["$option"]:-}"

    [[ -n "$definition" ]] || return 0

        IFS='|' read -r function description variable <<< "$definition"

        printf "   [%s] %-25s : %s\n" \
            "$option" \
            "$description" 
    done

    printf "\n"
    printf "\n"
    printf " Actions\n"
    printf " ────────────────────────────────────────────────────────────────────────────────\n"
    printf " [z] Exit\n"
    printf "\n"
    printf "================================================================================\n"
}
