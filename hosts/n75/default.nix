{ config, lib, pkgs, rootPath, ... } @ args:

with lib;

let

  username = "christian";
  moduleArgs = args // { inherit username; };

in

{
  imports = [
    ./hardware
    ./devmail
    (import ./fileSystems moduleArgs)
    (import ./openvpn moduleArgs)
    ./printing
  ];

  custom.base.users.users = [ username ];
  custom.desktop.mobile.enable = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
