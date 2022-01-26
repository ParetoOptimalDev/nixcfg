{ config, lib, ... }:

with lib;

let

  usersCfg = config.custom.base.users;

in

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  users.users = genAttrs usersCfg.usernames (u: { extraGroups = [ "docker" ]; });
}
