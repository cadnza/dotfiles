# Keep PATH free of duplicates when this file is sourced more than once
# (see the end of this file; assigning to $PATH doesn't dedupe by itself)
typeset -U path

# Add sbin to path
export PATH=/usr/local/sbin:$PATH

# Add user binaries to path (for canonicity's sake; don't deliberately put any user executables here)
export PATH=$HOME/bin:$PATH

# Add included executables to path
export PATH=$HOME/.support/executables:$PATH

# Add pub to path (for Flutter)
export PATH=$PATH:$HOME/.pub-cache/bin

# Source Apple Silicon homebrew eval script (which adds brew to path)
[ -d /opt/homebrew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Add lsregister location to path on macOS (for finding URI schemes)
# You can list registered URI scheme bindings with `lsregister -dump URLSchemeBinding`.
# Optionally throw on a `| sort` to sort the output.
[[ $OSTYPE == darwin* ]] && export PATH=$PATH:/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/

# Add hidden local to path (this is where user executables go)
export PATH=$HOME/.local/bin:$PATH

# Add path to cargo binaries
export PATH=$PATH:$HOME/.cargo/bin

# Add path to LM Studio CLI
export PATH=$PATH:$HOME/.lmstudio/bin

# Dedupe PATH (first occurrence wins)
path=($path)
