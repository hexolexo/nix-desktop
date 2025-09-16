#!/bin/bash
echo "Pushing changes..."
git push "$@"
if [ $? -eq 0 ]; then
    echo "=== Push successful, installing desktop ==="
    sudo sh -c 'cd /etc/nixos && git pull && nix-channel --update && nixos-rebuild switch' && git push github master
else
    echo "Push failed, deployment aborted"
    exit 1
fi
