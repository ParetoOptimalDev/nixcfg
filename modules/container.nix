{ config, pkgs, ... }:

let

  username = import ../username.nix;

in

{
  environment.systemPackages = with pkgs; [
    docker-compose
    docker-ls
    lazydocker
  ];

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users.${username}.extraGroups = [ "docker" ];
}
