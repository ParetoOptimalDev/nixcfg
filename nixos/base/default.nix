{ config, lib, pkgs, rootPath, ... } @ args:

with lib;

let

  cfg = config.custom.base;

  localeLang = "en_US.UTF-8";
  localeFormats = "de_CH.UTF-8";

  availableUsers = [ "christian" ];
  importUser = u:
    let
      isEnabled = any (x: x == u) cfg.users;
      userConfig = ./. + "/users/${u}.nix";
      userArgs = args // { inherit isEnabled; };
    in
    import userConfig userArgs;
  importUsers = (map importUser availableUsers);

in

{

  options = {

    custom.base = {
      enable = mkEnableOption "basic config" // { default = true; };

      hostname = mkOption {
        type = types.enum [ "altair" "n75" "nixos-vm" ];
        description = "Host name.";
      };

      users = mkOption {
        type = types.listOf (types.enum availableUsers);
        default = [ ];
        description = "List of user names.";
      };
    };
  };

  config = mkIf cfg.enable
    {

      boot = {
        cleanTmpDir = true;
      };

      home-manager = {
        backupFileExtension = "hm-bak";
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit rootPath; };
        sharedModules = homeModules;

        users = genAttrs cfg.users (u: import (rootPath + "/hosts/${baseCfg.hostname}/home-${u}.nix"));
      };

      i18n = {
        defaultLocale = localeLang;
        extraLocaleSettings = {
          LC_NUMERIC = localeFormats;
          LC_TIME = localeFormats;
          LC_MONETARY = localeFormats;
          LC_PAPER = localeFormats;
          LC_MEASUREMENT = localeFormats;
        };
      };

      location = {
        latitude = 47.5;
        longitude = 8.75;
      };

      networking = {
        hostName = cfg.hostname;
      };

      nix = {
        package = pkgs.nix_2_4;
        extraOptions = ''
          experimental-features = nix-command flakes
        '';
        gc = {
          automatic = true;
          dates = "04:00";
          options = "--delete-older-than 7d";
        };
      };

      nixpkgs.config.allowUnfree = true;

      programs = {
        vim.defaultEditor = true;
        zsh.enable = true;
      };

      security.sudo.package = pkgs.sudo.override {
        withInsults = true;
      };

      services = {
        logind.extraConfig = ''
          HandlePowerKey=ignore
        '';
      };

      system = {
        # This value determines the NixOS release with which your system is to be
        # compatible, in order to avoid breaking some software such as database
        # servers. You should change this only after NixOS release notes say you
        # should.
        stateVersion = "21.11";
      };

      time.timeZone = "Europe/Zurich";
    } // mkMerge importUsers;
}
