{ pkgs, ... }:

{
  imports = [
    ./steam
  ];

  home.packages = with pkgs; [
    # Comms
    discord
    teamspeak_client

    # Game libs
    lutris

    # Games
    superTux
    superTuxKart
    wesnoth
    zeroad
  ];
}
