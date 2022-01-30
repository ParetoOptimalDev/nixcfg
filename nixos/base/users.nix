{ config, lib, pkgs, homeModules, rootPath, ... } @ args:

with lib;

let

  cfg = config.custom.base.users;
  baseCfg = config.custom.base;

  availableUsers = [ "christian" ];
  importUserModule = u:
    let
      isEnabled = any (x: x == u) cfg.users;
      userConfig = ./users + "/${u}.nix";
    in
    mkIf isEnabled (import userConfig args);
  importUserModules = map importUserModule availableUsers;

  importHmUser = with config.lib.custom;
    u: import (mkHostPath baseCfg.hostname "/home-${u}.nix");
  hmUsers = genAttrs cfg.users importHmUser;

in

{
  imports = importUserModules;

  options = {

    custom.base.users = {
      users = mkOption {
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
      users = hmUsers;
    };
  };
}
