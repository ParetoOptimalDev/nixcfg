{ config, pkgs, ... }:

let

  username = import ../username.nix;

in

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.${username}.extraGroups = [ "docker" ];
}
