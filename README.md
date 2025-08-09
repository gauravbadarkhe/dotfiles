# ⚙️ My Dotfiles

Welcome to my personal dotfiles repository! These dotfiles manage my development environment across various machines, ensuring a consistent and efficient workflow.

## ✨ What are Dotfiles?

Dotfiles are configuration files for applications and tools that start with a `.` (dot) and are usually hidden in your home directory. They control everything from your shell prompt and editor settings to your terminal multiplexer and version control configurations.

I use [Chezmoi](https://www.chezmoi.io/) to manage these dotfiles, which allows me to securely and idempotently deploy my configurations across different systems.

## 🚀 Installation & Usage with Chezmoi

To use these dotfiles, you'll need to have [Chezmoi](https://www.chezmoi.io/install/) installed on your system.

1.  **Install Chezmoi:**

    ```bash
    # On macOS
    brew install chezmoi

    # On Linux (example for Debian/Ubuntu)
    sudo apt install chezmoi
    # Or download from https://www.chezmoi.io/install/
    ```

2.  **Clone and Apply Dotfiles:**

    ```bash
    chezmoi init --apply https://github.com/gauravbadarkhe/dotfiles.git
    ```

    **Note:** Replace `gauravbadarkhe` and `dotfiles` with your actual GitHub username and repository name.

    This command will:

    - Initialize Chezmoi.
    - Clone this repository.
    - Apply the dotfiles to your home directory, respecting any templating or sensitive data handling configured in Chezmoi.

3.  **Update Dotfiles:**
    To pull the latest changes from this repository and apply them:
    ```bash
    chezmoi update
    ```

## 🛠️ Included Configurations

This repository includes configurations for:

- **Neovim (`private_dot_config/nvim`):** My highly customized Neovim setup, including plugins, keymaps, and LSP configurations for a powerful IDE-like experience.
- **Tmux (`dot_tmux.conf`, `dot_tmux/plugins`):** My Tmux configuration for session management, pane navigation, and various plugins (like `tmux-resurrect` and `tmux-continuum`).
- **Zsh (`dot_zshrc`):** My Zsh shell configuration, including aliases, functions, and prompt settings.
- **Custom Binaries (`bin`):** Useful scripts and executables for common tasks.
- **Git (`executable_dot_git-switch-branch.sh`, `executable_dot_git-view-file.sh`):** Custom Git helper scripts.

## 🤝 Contributing

Feel free to explore, fork, and adapt these dotfiles for your own use. If you find any issues or have suggestions for improvements, please open an issue or submit a pull request.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.
