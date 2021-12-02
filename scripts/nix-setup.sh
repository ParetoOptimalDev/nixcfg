#!/usr/bin/env bash

set -e
set -x

ln -s "./home/$(hostname).nix" home.nix
ln -s "$(pwd)" ~/.config/nixpkgs
printf "keep-derivations = true\nkeep-outputs = true\n" >> /etc/nix/nix.conf

