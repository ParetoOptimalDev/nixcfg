{ config, pkgs, inputs, system, ... }:

{
  home.packages = with pkgs; [
    # Bluetooth
    bluez

    _1password
    pulseaudio
    xorg.xrandr
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

      # Display setup
      "bin/display-docked" = {
        source = ./scripts/display-docked;
        target = userBin + "/display-docked";
        executable = true;
      };
      "bin/display-extended" = {
        source = ./scripts/display-extended;
        target = userBin + "/display-extended";
        executable = true;
      };
      "bin/display-extended-left" = {
        source = ./scripts/display-extended-left;
        target = userBin + "/display-extended-left";
        executable = true;
      };
      "bin/display-mirror" = {
        source = ./scripts/display-mirror;
        target = userBin + "/display-mirror";
        executable = true;
      };
      "bin/display-single" = {
        source = ./scripts/display-single;
        target = userBin + "/display-single";
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
