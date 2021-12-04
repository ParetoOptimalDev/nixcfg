{ config, ... }:

{
  imports = [
    ./bin
    ./fonts
    ./git
    ./hardware
    ./shell
    ./vim
  ];

  home = {
    username = "christian";
    homeDirectory = "/home/${config.home.username}";

    sessionPath = [
      "$HOME/bin"
    ];

    enableNixpkgsReleaseCheck = true;
    stateVersion = import ../../../version.nix;
  };
}
