{ config, pkgs, inputs, system, ... }:

{
  home.packages = [
    pkgs.ranger
  ];

  xdg.dataFile."ranger/bookmarks".text = ''
    # Common
    d:${config.home.homeDirectory}/Downloads
    h:/mnt/home/home
  '';
}
