#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

. $SCRIPT_DIR/scripts/lib.sh

 #These commands are from base image , which takes care of
 # - installing asdf plugin and tools from $HOME/.tool-versions
 # - setting up asdf binary path , asdf helpers and, asdf completion scripts
function tool_installation(){

    cp "${PROJECT_ROOT}/.tool-versions" "$HOME"

    #This line ensures asdf poetry plugin uses the poetry package from specified location
    # Link to plug-in documentation https://github.com/asdf-community/asdf-poetry?tab=readme-ov-file#overriding-installer
    export ASDF_POETRY_INSTALL_URL='https://install.python-poetry.org'

    . "${ASDF_RC}"

    asdf_install
}

function on_create(){

    tool_installation

    # These commands are from lib.sh and mainly does configuration
    configure_poetry "${PROJECT_ROOT}"
    install_git_bash_prompt
    update_and_install_packages "${PROJECT_ROOT}"
    update_and_install_pre_commit_hooks "${PROJECT_ROOT}"
    set +u; configure_git

    #Make shell library functions available
    echo "" >> "${HOME}/.bashrc"
    echo ". $SCRIPT_DIR/scripts/lib.sh" >> "${HOME}/.bashrc"
}

on_create
