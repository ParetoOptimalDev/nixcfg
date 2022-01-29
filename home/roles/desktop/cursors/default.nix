{ pkgs, ... }:

with pkgs;

{
  home.packages = [
    dconf
  ];

  gtk.enable = true;

  xsession = {
    enable = true;
    pointerCursor = {
      package = bibata-extra-cursors;
      size = 22;
    };
  };
}
