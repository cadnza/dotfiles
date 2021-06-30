# Shell Dotfiles

*Zsh* dotfiles, specifically. Here's what I've got:

### A beautiful prompt

- Colorblind-safe colors for user, machine, and directory
- Most colors within the first 15 Xterm colors for per-emulator customization

### Handy Git indicators

- Branch and repo to the right that  disappear when you type over them
- Smart change indicators that show for staged and unstaged changes *only* when displaying them doesn't slow down the terminal
- A subtle indicator for repos that are too large for change indicators
- Fast unpushed and unpulled commit indicators for all repos, regardless of size
- No effect on performance in directories that aren't repos

### A very handy `.nanorc`

- Highlighting for most languages (special thanks to [Benjamin Chan](https://gist.github.com/benjamin-chan) for [R](https://gist.github.com/benjamin-chan/4ef37955eabf5fa8b9e70053c80b7d76#file-r-nanorc) and [Anthony Scopatz](https://github.com/scopatz) for [Swift](https://github.com/scopatz/nanorc/blob/master/swift.nanorc))
- Line numbering
- High contrast without giving you a headache
- A nice ruler at 80 characters
- A scroll bar (Well, an indicator anyway. You can't scroll with it.)

### A play area for functions

- All of scripts get sourced on startup

### Short files and easy setup

- Because short files are happy files. 🙂

### Syntax highlighting with [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

### Aliases, path, etc.

- You get it.

## Setup

Nice and easy. Here's what you do:

1. Pull the repo
2. Symlink `.zshrc`, `.nanorc`, and `.shDotFileSupport` into `~` by those names (and `.Rprofile` if you want)
3. Start your zsh 😎
