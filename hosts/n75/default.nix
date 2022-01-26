{ pkgs, rootPath, ... }:

let

  username = "christian";

in

{
  imports = [
    ./hardware
    #(import ./devmail { inherit pkgs rootPath; })
    #(import ./fileSystems { inherit pkgs username; })
    #(import ./openvpn { inherit username; })
    #./printing
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #custom.desktop.mobile.enable = true;
}
