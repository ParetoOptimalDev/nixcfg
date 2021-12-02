{ config, pkgs, ... }:

{
  imports = [
    ./common.nix

    ./desktop.nix
    ./direnv.nix
    ./input.nix
    ./network.nix
    ./packages.nix
    ./printing.nix
    ./software.nix
    ./sound.nix
    ./user
    ./virtualbox.nix
    ./vpn.nix
  ];
}
