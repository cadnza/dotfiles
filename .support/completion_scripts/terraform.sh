# Enable terraform completion if terraform is installed
f_terraform=$(command -v terraform) && {
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C "$f_terraform" terraform &>/dev/null
}
