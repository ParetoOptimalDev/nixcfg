{ pkgs, ... }:

{
  imports = [
    ./kmonad
    ./udiskie
  ];

  home.packages = with pkgs; [
    parted
    exfat
    samba
  ];
}
