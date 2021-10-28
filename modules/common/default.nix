{ config, pkgs, ... }:

{
  imports = [
    ./common.nix

    ./accounts.nix
    ./desktop.nix
    ./direnv.nix
    ./id.nix
    ./input.nix
    ./network.nix
    ./nextcloud.nix
    ./packages.nix
    ./printing.nix
    ./redshift.nix
    ./software.nix
    ./sound.nix
    ./user.nix
    ./virtualbox.nix
    ./vpn.nix
  ];
}
