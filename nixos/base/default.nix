{ config, lib, pkgs, rootPath, ... }:

with lib;

let

  cfg = config.custom.base.general;

  localeLang = "en_US.UTF-8";
  localeFormats = "de_CH.UTF-8";

in

{

  options = {

    custom.base.general = {
      enable = mkEnableOption "basic config" // { default = true; };

      hostname = mkOption {
        type = types.enum [ "altair" "n75" "nixos-vm" ];
        description = "Host name.";
      };
    };
  };

  config = mkIf cfg.enable {

    boot = {
      cleanTmpDir = true;
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
      stateVersion = import (rootPath + "/version.nix");
    };

    time.timeZone = "Europe/Zurich";
  };
}
