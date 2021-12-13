{ pkgs, ... }:

{
  imports = [
    ./kmonad
    ./udiskie
    ./xbindkeys
  ];

  home.packages = with pkgs; [
    parted
    exfat
    samba
  ];
}
