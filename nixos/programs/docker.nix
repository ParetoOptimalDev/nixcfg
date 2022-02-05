{ config, lib, ... }:

with lib;

let

  baseCfg = config.custom.base;

in

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users = genAttrs baseCfg.users (u: { extraGroups = [ "docker" ]; });
}
