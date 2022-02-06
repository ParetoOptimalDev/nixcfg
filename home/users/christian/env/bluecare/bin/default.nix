{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.users.christian.env.bluecare.bin;

  mkUserBinScript = name:
    {
      name = "bin/${name}";
      value = {
        source = ./scripts + "/${name}";
        target = config.home.homeDirectory + "/bin/${name}";
        executable = true;
      };
    };

in

{
  options = {
    custom.users.christian.env.bluecare.bin = {
      enable = mkEnableOption "User bin scripts";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      docker-ls
      freerdp
      xorg.xrandr
    ];

    xdg.configFile = listToAttrs (map mkUserBinScript [
      # Display setup
      "display-docked"
      "display-extended"
      "display-extended-left"
      "display-mirror"
      "display-single"

      "dockerrm"
      "terminalserver"
    ]);
  };
}
