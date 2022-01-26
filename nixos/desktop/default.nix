{
  imports = [
    ./input.nix
    ./mobile.nix
  ];

  services = {
    xserver = {
      enable = true;
      desktopManager.xterm.enable = true;
    };
  };
}
