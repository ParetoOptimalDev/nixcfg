#!/usr/bin/env bash

set -e
set -x

cd "$(dirname "$0")" || exit
VERSION=$(tr -d '"' < ../version.nix)

pushd ..
niv update nixpkgs -v "$VERSION"
popd
