{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pkgs.zoom-us
  ];

  xdg.configFile."zoomus.conf".source = ./config/zoomus.conf;
}
