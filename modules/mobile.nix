{
  networking.wireless.enable = true;

  services = {
    logind.lidSwitch = "suspend-then-hibernate";
    upower.enable = true;
    xserver = {
      dpi = 96;
      videoDrivers = [
        "nvidia"
      ];
    };
  };
}
