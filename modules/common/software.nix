{ config, pkgs, ... }:

with pkgs.lib;

{
  imports = import ../../pkgs/modules.nix;

  options.software = {

    common = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ ];
    };

    x = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ ];
    };

    image = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ ];
    };

    multimedia = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ ];
    };

    web = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ ];
    };

    dev = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ ];
    };

    office = mkOption {
      type = types.listOf types.package;
      default = with pkgs; [ ];
    };

    extra = mkOption {
      type = types.listOf types.package;
      default = [ ];
    };

    blacklist = mkOption {
      type = types.listOf types.package;
      default = [ ];
    };

  };

  config = {
    environment.systemPackages =
      let
        ff = p: ! builtins.elem p config.software.blacklist;
        all = config.software.common ++
          config.software.x ++
          config.software.image ++
          config.software.multimedia ++
          config.software.web ++
          config.software.dev ++
          config.software.office ++
          config.software.extra;
      in
      builtins.filter ff all;
  };
}
