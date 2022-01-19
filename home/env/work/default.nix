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
    ./zoomus
  ];

  home.packages = with pkgs; [
    robo3t
    slack
    teams
  ];
}
