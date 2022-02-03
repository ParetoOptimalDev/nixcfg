{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.office;

in

{
  options = {
    custom.roles.office = {
      enable = mkEnableOption "Office";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      libreoffice
      sent # plaintext presentations
    ];
  };
}
