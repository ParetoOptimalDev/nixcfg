{ config, options, lib, pkgs, ... }:

with lib;
with builtins;

let

  cfg = config.services.kmonad;

in

{
  options.services.kmonad = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable KMonad service.
      '';
    };

    configFile = mkOption {
      type = types.path;
      default = null;
      example = ''
        ./my-config.kbd;
      '';
      description = ''
        The kmonad configuration file.
      '';
    };

    package = mkOption {
      type = types.package;
      default = pkgs.kmonad;
      description = ''
        The kmonad package.
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    systemd.user.services = {
      kmonad = {
        Unit = {
          Description = "KMonad";
        };
        Service = {
          Type = "simple";
          Restart = "always";
          RestartSec = 10;
          ExecStart = "${cfg.package}/bin/kmonad ${cfg.configFile}";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
      };
    };
  };
}
