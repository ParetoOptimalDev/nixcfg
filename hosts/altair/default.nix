{ config, pkgs, ... }:

{
  imports = [ ./hardware ];

  custom.base.users.users = [ "christian" ];
  custom.desktop.enable = true;
  custom.desktop.gaming = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
