{ config, pkgs, ... }:

{
  imports = [ ./hardware ];

  custom.base.users.usernames = [ "christian" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
