#!/usr/bin/env sh

# Make file inferrable to Prettier
ext=".$1"
fOriginal="$2"
fRenamed="$fOriginal.$ext"
mv "$fOriginal" "$fRenamed"

# Format
# Note that .prettierrc doesn't need to be explicitly specified, but it does make
# the editor error after the fact if there's no .prettierrc, which is what we want.
prettier --config "$HOME/.prettierrc" --write "$fRenamed"

# Replace file
mv "$fRenamed" "$fOriginal"

# Exit
exit 0
