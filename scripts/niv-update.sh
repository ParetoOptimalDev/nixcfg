#!/usr/bin/env bash

set -x

cd $(dirname "$0")
VERSION=$(cat ../version.nix | tr -d '"')

cd ..
niv update nixpkgs -v $VERSION
