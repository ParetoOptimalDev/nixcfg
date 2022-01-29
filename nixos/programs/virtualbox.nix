{ config, lib, ... }:

with lib;

let

  baseCfg = config.custom.base;

in

{
  users.extraGroups.vboxusers.members = baseCfg.users;
}
