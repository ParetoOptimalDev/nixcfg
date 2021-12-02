#!/usr/bin/env bash

set -e
set -x

ln -s "$(pwd)/flake.nix" /etc/nixos/flake.nix

