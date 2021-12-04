{ pkgs, ... }:

{
  imports = [
    ./bin
    ./cli-office
    ./davmail
    ./git
    ./grobi
    ./icons
    ./ranger
    ./scala
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
