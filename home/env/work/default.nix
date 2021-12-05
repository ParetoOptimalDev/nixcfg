{ pkgs, ... }:

{
  imports = [
    ./bin
    ./cli-office
    ./davmail
    ./git
    ./grobi
    ./icons
    ./kmonad
    ./ranger
    ./scala
    ./spectrwm
    ./tmux
    ./xbindkeys
  ];

  home.packages = with pkgs; [
    robo3t
    slack
    teams
    zoom-us
  ];
}
