#!/usr/bin/env bash

set -x

ln -s `pwd` ~/.config/nixpkgs
echo "keep-derivations = true\nkeep-outputs = true" >> /etc/nix/nix.conf

