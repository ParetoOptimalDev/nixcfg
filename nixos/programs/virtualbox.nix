{ config, lib, ... }:

with lib;

let

  usersCfg = config.custom.base.users;

in

{
  users.extraGroups.vboxusers.members = usersCfg.usernames;
}
