{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    numlockx
  ];

  services.xserver = {
    displayManager = {
      sessionCommands = ''
        numlockx on
      '';
    };

    layout = "ch";
    xkbOptions = "caps:swapescape";

    # Touchpad settings
    libinput = {
      enable = true;
      naturalScrolling = true;
      disableWhileTyping = true;
      sendEventsMode = "disabled-on-external-mouse";
    };
  };
}
