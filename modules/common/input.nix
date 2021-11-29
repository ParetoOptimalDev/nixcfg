{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xbindkeys
  ];

  services.xserver = {
    displayManager = {
      sessionCommands = ''
        xbindkeys
      '';
    };

    layout = "ch";

    # Touchpad settings
    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        disableWhileTyping = true;
        sendEventsMode = "disabled-on-external-mouse";
      };
    };
  };
}
