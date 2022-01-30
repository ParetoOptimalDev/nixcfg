{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.base;

in

{
  imports = [
    ./locale.nix
    ./nix.nix
    ./users.nix
  ];

  options = {
    custom.base = {
      hostname = mkOption {
        type = types.enum [ "altair" "n75" "nixos-vm" ];
        description = "Host name.";
      };
    };
  };

  config = {

    boot = {
      cleanTmpDir = true;
    };

    networking = {
      hostName = cfg.hostname;
    };

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
  };
}
