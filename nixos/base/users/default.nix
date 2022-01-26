{ config, lib, pkgs, homeModules, rootPath, ... } @ args:

with lib;

let

  cfg = config.custom.base.users;
  baseCfg = config.custom.base;

  availableUsers = [ "christian" ];
  importUser = u:
    let
      isEnabled = any (x: x == u) cfg.usernames;
      userConfig = ./. + "/${u}.nix";
      userArgs = args // { inherit isEnabled; };
    in
    import userConfig userArgs;
  importUsers = (map importUser availableUsers);

in

{

  options = {

    custom.base.users = {

      usernames = mkOption {
        type = types.listOf (types.enum availableUsers);
        default = [ ];
        description = "List of user names.";
      };
    };
  };

  config = {

    home-manager = {
      backupFileExtension = "hm-bak";
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = { inherit rootPath; };
      sharedModules = homeModules;

      users = genAttrs cfg.usernames (u: import (rootPath + "/hosts/${baseCfg.hostname}/home-${u}.nix"));
    };
  } // mkMerge importUsers;
}
