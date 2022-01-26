{ pkgs, ... }:

{
  gtk.enable = true;

  xsession = {
    enable = true;
    pointerCursor = {
      package = pkgs.bibata-extra-cursors;
      size = 22;
    };
  };
}
