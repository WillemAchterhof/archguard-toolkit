#!/usr/bin/env bash
# ==============================================================================
#  ArchGuard Tools — Repository Check
# ==============================================================================
#  lib/check-repository.sh
#
#  Provides:
#    check_repository <repository> <target_dir>
#
#  Initializes target_dir as a git repo pointing at the given GitHub
#  repository (if not already), then verifies it's reachable.
# ==============================================================================

check_repository()
{
    local repository="${1:?ERROR: repository name required}"
    local target_dir="${2:?ERROR: target directory required}"
    local repo_url="https://github.com/WillemAchterhof/${repository}.git"

    log_tools "Checking repository access: $repository"

    mkdir -p -- "$target_dir"
    cd -- "$target_dir"

    if [[ ! -d .git ]]; then
        log_tools "Repository not initialized, initializing..."
        git init
        git remote add origin "$repo_url"
    fi

    git ls-remote origin >/dev/null 2>&1 \
        || {
            log_tools "ERROR: Unable to reach repository: $repo_url"
            return 1
        }

    log_tools "Repository access confirmed: $repository"
}
