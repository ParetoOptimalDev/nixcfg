{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pkgs.unstable.zoom-us
  ];

  xdg.configFile."zoomus.conf".source = ./config/zoomus.conf;
}
