{
  services.xserver = {
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
