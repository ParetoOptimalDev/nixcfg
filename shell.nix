{ pkgs ? import (import ./nix/sources.nix).nixpkgs { }, project ? import ./nix { inherit pkgs; } }:

with project.pkgs;

mkShell {

  name = "nixos-config";

  buildInputs = [
    figlet
    lolcat # banner printing on enter

    home-manager
  ];

  shellHook = ''
    figlet $name | lolcat --freq 0.5
  '';
}

