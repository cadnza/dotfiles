#!/usr/bin/env zsh

# Enable completion for gcloud
compsgcloud="$HOME/.google-cloud-sdk/completion.zsh.inc"
[ -f $compsgcloud ] && source $compsgcloud
