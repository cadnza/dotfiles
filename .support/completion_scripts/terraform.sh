# Enable terraform completion if terraform is installed
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform &>/dev/null
