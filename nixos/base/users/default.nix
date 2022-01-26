{ config, lib, pkgs, homeModules, rootPath, ... }:

with lib;

let

  cfg = config.custom.base.users;
  baseCfg = config.custom.base;

in

{

  options = {

    custom.base.users = {
      usernames = mkOption {
        type = types.listOf (types.enum [ "christian" ]);
        default = [ "christian" ];
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
  } // (import ./christian.nix { inherit pkgs; });
}
