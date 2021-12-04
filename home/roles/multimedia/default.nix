{ pkgs, ... }:

{
  home.packages = with pkgs; [
    id3lib
    spotifywm
  ];

  programs.mpv.enable = true;
}
