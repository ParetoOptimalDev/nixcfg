{ config, pkgs, inputs, system, ... }:

{
  home.packages = [
    pkgs.ranger
  ];

  xdg.dataFile."ranger/bookmarks".text = ''
    # Home
    s:/mnt/home/home/Scan
    p:/mnt/home/public
  '';
}
