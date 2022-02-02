{ config, ... }:

{
  home = {
    homeDirectory = "/home/${config.home.username}";

    sessionPath = [
      "$HOME/bin"
    ];

    enableNixpkgsReleaseCheck = true;

    stateVersion = "21.11";
  };
}
