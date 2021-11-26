{ config, pkgs, ... }:

let

  username = import ../username.nix;

in

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    docker_compose
    nfs-utils
  ];

  virtualisation.docker.enable = true;

  users.users.${username}.extraGroups = [ "docker" ];
}
