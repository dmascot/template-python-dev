#!/usr/bin/env bash

function configure_poetry(){
    PROJECT_ROOT="$1"

    poetry config virtualenvs.in-project true
    poetry completions bash > /etc/bash/poetry.sh
    poetry self add poetry-plugin-up
    poetry self add poetry-plugin-export

    echo "\n" >> "${HOME}/.bashrc"
    cat << EOF | tee "${HOME}/.bashrc" >> /dev/null
if [ -f "$PROJECT_ROOT/pyproject.toml" ]; then
    source \$(poetry env info --path)/bin/activate
else
    echo "Project not initialized: $PROJECT_ROOT/pyproject.toml not found. Please run 'poetry init' to start a new project."
fi
EOF
}

function update_and_install_packages(){
    PROJECT_ROOT="$1"

    if [ -f "${PROJECT_ROOT}/poetry.lock" ]
    then
        poetry lock
    fi


    if [ -f "${PROJECT_ROOT}/pyproject.toml" ]
    then
        poetry up
        poetry install
    fi
}

function install_git_bash_prompt(){
    if [ ! -d "${HOME}/.bash-git-prompt" ]
    then
        git clone https://github.com/magicmonty/bash-git-prompt.git  ${HOME}/.bash-git-prompt --depth=1

        echo 'if [ -f "${HOME}/.bash-git-prompt/gitprompt.sh" ]; then
        GIT_PROMPT_ONLY_IN_REPO=1
        source "$HOME/.bash-git-prompt/gitprompt.sh"
fi' >> ${HOME}/.bashrc

    fi
}

function update_and_install_pre_commit_hooks(){
    PROJECT_ROOT="$1"
    PRE_COMMIT_FILE="$PROJECT_ROOT/.pre-commit-config.yaml"

    if [[ -f "$PRE_COMMIT_FILE" ]]; then
        if ! command -v pre-commit  2>&1; then
            echo "pre-commit not installed, please install it"
        else
            pre-commit autoupdate
            pre-commit install
        fi
    fi
}


function configure_git(){
    git config --global core.editor "code -w"

    if [ !  -n "${GIT_USER_NAME:-}" ]
    then
        git config --global user.name "${GIT_USER_NAME}"
    fi

    if [ !  -n "${GIT_EMAIL:-}" ]
    then
        git config --global user.email "${GIT_EMAIL}"
    fi
}