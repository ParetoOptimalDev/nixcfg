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
    ./ssh
    ./tmux
    ./xbindkeys
  ];

  home.packages = with pkgs; [
    robo3t
    slack
    teams
    pkgs.unstable.zoom-us
  ];
}
