#!/usr/bin/env bash
# ==============================================================================
#  ArchGuard Tools — Global Variables & Functions
# ==============================================================================
#  lib/global-dependencies.sh
#
#  Sources shared library functions used across Tools/*.sh scripts.
# ==============================================================================

TOOLS_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TOOLS_LIB="$TOOLS_ROOT/lib"

log_tools()
{
    printf '[ArchGuard Tools] %s\n' "$*"
}

for file in "$TOOLS_LIB"/*.sh; do
    [[ -f "$file" ]] || continue
    source "$file"
done
