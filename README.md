# Shell Dotfiles

**Zsh** dotfiles, specifically. Here's what you get:

### A beautiful prompt

-   Colorblind-safe colors for user, machine, and directory
-   Most colors within the first 15 Xterm colors for per-emulator customization
-   Machine color that changes by OS
-   Exit code indicator that changes by status
-   Prompt color definitions in `.support/prompts/basic.sh`, and machine colors in `.support/colors.sh`

### Git indicators

-   Branch and repo to the right that disappear when you type over them
-   Staged (`+`) and unstaged (`*`) change indicators

### A very handy `.nanorc`

-   Line numbering
-   High contrast without giving you a headache
-   A nice ruler at 80 characters
-   A scroll bar (Well, an indicator anyway. You can't scroll with it.)
-   Syntax highlighting from the system's nano syntax files

### Completions

-   Generated on demand for `docker`, `op`, and `rustup` (into the gitignored `.support/completion_functions_dynamic`, and refreshed when the tool is updated)
-   Hand-written loaders for `gcloud` and `terraform` in `.support/completion_scripts`

### Syntax highlighting

-   With [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### Extras

-   `.support/banners.sh`: shows detached tmux and screen sessions on startup
-   `.support/executables/cleanup-macos`: interactive macOS cleanup (caches, logs, Docker, Homebrew, Cargo artifacts)
-   `zed/`: [Zed](https://zed.dev/) settings and keymap

### Short files and easy setup

-   Because short files are happy files. 🙂

## Setup

Nice and easy. Here's what you do:

1. Pull the repo
2. Symlink `.zshrc`, `.nanorc`, and `.support` into `~` by those names
3. Machine-specific settings go in `~/.localrc` (optional), and a prompt theme name in `~/.prompt` (optional)
4. Start your zsh 😎
