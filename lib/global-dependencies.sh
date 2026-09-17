#!/usr/bin/env bash

# ------------------------------------------------------------------------------
# ArchGuard Toolkit — Global Dependencies
# ------------------------------------------------------------------------------
# lib/global-dependencies.sh
# ------------------------------------------------------------------------------

SCRIPT_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
TOOLS_LIB="$SCRIPT_ROOT/lib"

log_tools()
{
    printf '[ArchGuard Toolkit] %s\n' "$*"
}

for file in "$TOOLS_LIB"/*.sh; do
    [[ -f "$file" ]] || continue
    [[ "$file" == "$BASH_SOURCE" ]] && continue

    source "$file"
done