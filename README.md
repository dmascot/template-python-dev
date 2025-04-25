# Python Dev Container Template

This is a opinionated **template repository** designed to bootstrap a modern Python development environment using:

- **VS Code Dev Containers**
- **ASDF** for tool version management
- **Poetry** for Python dependency and environment management
- **Git bash prompt** for visibality at cli
- Optional **Pre-commit hooks** for enforcing code quality
- Optional **Git configuration** via environment variables

## What's Included?

| Feature                | Description                                                           |
| ---------------------- | --------------------------------------------------------------------- |
| `devcontainer.json`    | Spins up a preconfigured Docker-based Python environment with VS Code |
| `.tool-versions`       | Ensures consistent versions of tools across dev machines              |
| `poetry`               | Manages dependencies and virtualenvs in-project                       |
| `pre-commit-config.yaml`| an example pre-commit hooks with config and updates hooks            |
| pre-commit helper      | enable auto update of pre-commit hooks and installation ( if pre-commit is installed) |
| Git auto-configuration | Sets up Git identity inside container using env vars                  |
| Git bash prompt        | Adds repo-aware prompt for easy context                               |

## Getting Started

### 1. Prerequisites

- [Docker](https://www.docker.com/)
- [VS Code](https://code.visualstudio.com/)
- VS Code Extension: **Dev Containers**

### 2. Quick Start

1. **Use this repo as a template** (click "Use this template" on GitHub)
2. Clone your new repository:

   ```bash
   git clone https://github.com/dmascot/template-python-dev.git
   cd template-python-dev
   ```

3. Open the repo in VS Code

4. VS Code will prompt:
   Reopen in Container → ✅ click it!

5. Automatically installs ASDF plugins and their versions defined in `.tool-versions`

### What Gets Bootstrapped?

When the container is created, the .devcontainer/on-create.sh script automatically runs to prepare your development environment. It performs the following:

- Copies .tool-versions to $HOME/.tool-versions
- Installs any missing ASDF plugins (e.g. Python, Poetry)
- Installs the exact tool versions defined in .tool-versions
- Installs poetry and creates an in-project virtual environment (if applicable)
- Installs and configures pre-commit hooks (if a .pre-commit-config.yaml is present)
- Optionally sets up Git user info from environment variables

- sources command from `.devcontainer/scripts/libs` to be able to execute them at later stage. In particular, following commands can be useful

  - `configure_git` to configure `github user and email` after setting variables ( if you did not set it before building container )
  - `update_and_install_packages` to update package versions and install them
  - `update_and_install_pre_commit_hooks` to install and update pre-commit hooks after `creating pre-commit-config.yaml`

**You can customize this behaviour in `devcontainer/on-create.sh`**

### 3 Configuration Options

#### Tool Versions (ASDF)

Tools are installed using ASDF via `.tool-versions:`

```bash
python 3.12.8
poetry 2.1.2
```

You can add more tools like `nodejs` with in `.tool-versions`:

```bash
nodejs 20.11.0
```

Note that , you may need to required dependencies too if you choose this path

#### Git Configuration via Env Vars

| Variable      | Purpose       | Where to set                     |
| ------------- | ------------- | -------------------------------- |
| GIT_USER_NAME | Git user name | .bashrc, .devcontainer/.env, etc |
| GIT_EMAIL     | Git email     | .bashrc, .devcontainer/.env, etc |

e.g.

```bash
export GIT_USER_NAME="Kewl Developer"
export GIT_EMAIL="kewl@devmail.com"
```

#### Customizing the Dev Container

🏷 Change the Dev Container Name

You can change the container name in .devcontainer/devcontainer.json:

```json
{
  "name": "python"
}
```

change `python` to anything

```json
{
  "name": "kewl-python-project"
}
```

## Contributing

This repo is designed to be forked and adapted. Feel free to tweak the setup for your use case!

## License

MIT
