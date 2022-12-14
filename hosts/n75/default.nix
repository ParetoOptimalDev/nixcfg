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
    base.users = [ username ];

    env.bluecare = {
      enable = true;
      inherit username;
    };

    roles.desktop = {
      enable = true;
      mobile.enable = true;
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
