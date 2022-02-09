{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.desktop.locker;

in

{
  options = {
    custom.roles.desktop.locker = {
      enable = mkEnableOption "Screen locker";

      package = mkOption {
        type = types.package;
        default = pkgs.i3lock-pixeled;
        description = "Locker package to use";
      };

      lockCmd = mkOption {
        type = types.str;
        default = "${pkgs.i3lock-pixeled}/bin/i3lock-pixeled";
        description = "Command to activate locker";
      };
    };
  };

  config = mkIf cfg.enable {

    home = {
      packages = [
        cfg.package
      ];
    };

    services = {
      screen-locker = {
        enable = true;
        xautolock.enable = false;

        inherit (cfg) lockCmd;
      };
    };
  };
}
