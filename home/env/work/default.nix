{ pkgs, ... }:

{
  imports = [
    #./bin
    #./cli-office
    #./cursors
    #./davmail
    #./git
    #./grobi
    #./kmonad
    #./ranger
    #./scala
    ##./xmonad
    #./ssh
    #./tmux
    #./xbindkeys
    #./zoomus
  ];

  home.packages = with pkgs; [
    robo3t
    slack
    teams
  ];
}
