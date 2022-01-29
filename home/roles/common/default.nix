{ config, ... }:

{
  imports = [
    ./bin
    ./fonts
    ./git
    ./hardware
    ./nix
    ./shell
    ./vim
  ];

  home = {
    homeDirectory = "/home/${config.home.username}";

    sessionPath = [
      "$HOME/bin"
    ];

    enableNixpkgsReleaseCheck = true;

    stateVersion = "21.11";
  };
}
