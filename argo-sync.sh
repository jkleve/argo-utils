#!/bin/bash
set -eo pipefail

__author="Jesse Kleve"
__version=0.1.0
__name="argo-sync"

function get_selection() {
    argocd app list | fzf --delimiter=' ' --nth=1 --height=40% --border --reverse --header-lines=1 --no-mouse
}

function main() {
    local selection= app=
    selection="$(get_selection)"
    app=$(printf "%s" "$selection" | cut -d' ' -f1)

    read -p "Sync $app? [yn] " -n 1 -r
    echo
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        echo "Syncing $app"
        argocd app sync "$app"
    else
        echo "No sync"
    fi
}

main

