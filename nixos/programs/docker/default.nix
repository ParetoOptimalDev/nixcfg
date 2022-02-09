{ config, lib, ... }:

with lib;

let

  cfg = config.custom.programs.docker;
  baseCfg = config.custom.base;

in

{
  options = {
    custom.programs.docker = {
      enable = mkEnableOption "Docker";
    };
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };

    users.users = genAttrs baseCfg.users (u: { extraGroups = [ "docker" ]; });
  };
}
