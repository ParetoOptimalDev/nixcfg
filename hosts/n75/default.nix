{ pkgs, rootPath, ... } @ args:

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

  custom.base.users.usernames = [ username ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #custom.desktop.mobile.enable = true;
}
