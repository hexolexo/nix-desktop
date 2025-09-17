#!/bin/bash
git push "$@"
if [ $? -eq 0 ]; then
    sudo sh -c 'cd /etc/nixos && git pull && nix-channel --update && nixos-rebuild switch' && timeout 5 git push github master
else
    echo "Push failed, deployment aborted"
    exit 1
fi
