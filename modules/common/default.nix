{ config, pkgs, ... }:

{
  imports = [
    ./common.nix

    #./accounts.nix # FIXME: cannot discover gitignored files
    ./desktop.nix
    ./direnv.nix
    ./input.nix
    ./network.nix
    ./nextcloud.nix
    ./packages.nix
    ./printing.nix
    ./software.nix
    ./sound.nix
    ./user
    ./virtualbox.nix
    ./vpn.nix
  ];
}
