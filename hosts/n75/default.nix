{ config, lib, pkgs, ... }:

with lib;

let

  username = "christian";

in

{
  imports = [
    ./hardware
  ];

  custom = {
    base.users.users = [ username ];

    env.bluecare = {
      enable = true;
      username = username;
    };

    roles.desktop = {
      enable = true;
      mobile = true;
    };

    containers.devmail = {
      enable = true;
      localDomains = [ "hin.ch" "test.com" ];
    };
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
