{ config, pkgs, inputs, system, ... }:

{
  home.packages = with pkgs; [
    docker-ls
    freerdp
  ];

  xdg.configFile =
    let
      userBin = config.home.homeDirectory + "/bin";
    in
    {
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
