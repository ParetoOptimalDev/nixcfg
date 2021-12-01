{ pkgs, inputs, system, ... }:

{
  home.packages = [
    pkgs.ranger
  ];

  xdg.dataFile."ranger/bookmarks".text = ''
    # Work
    H:/mnt/bluecare/home
    t:/mnt/bluecare/transfer
    T:/mnt/bluecare/transfer
  '';
}
