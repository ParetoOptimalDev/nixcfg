{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    docker-ls
    freerdp
    xorg.xrandr
  ];

  xdg.configFile =
    let
      userBin = config.home.homeDirectory + "/bin";
    in
    {
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

      "bin/dockerrm" = {
        source = ./scripts/dockerrm;
        target = userBin + "/dockerrm";
        executable = true;
      };
      "bin/terminalserver" = {
        source = ./scripts/terminalserver;
        target = userBin + "/terminalserver";
        executable = true;
      };
    };
}
