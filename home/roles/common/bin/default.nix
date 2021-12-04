{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Bluetooth
    bluez

    _1password
    pulseaudio
  ];

  programs = {
    feh.enable = true;
  };

  xdg.configFile =
    let
      userBin = config.home.homeDirectory + "/bin";
    in
    {
      # Bluetooth headset
      "bin/lib/btctl" = {
        source = ./scripts/lib/btctl;
        target = userBin + "/lib/btctl";
      };
      "bin/wh1000xm2-connect" = {
        source = ./scripts/wh1000xm2-connect;
        target = userBin + "/wh1000xm2-connect";
        executable = true;
      };
      "bin/wh1000xm2-disconnect" = {
        source = ./scripts/wh1000xm2-disconnect;
        target = userBin + "/wh1000xm2-disconnect";
        executable = true;
      };

      # Password CLI
      "bin/pass" = {
        source = ./scripts/pass;
        target = userBin + "/pass";
        executable = true;
      };
    };
}
