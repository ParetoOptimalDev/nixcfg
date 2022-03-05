{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.homeage;

in

{
  options = {
    custom.roles.homeage = {
      enable = mkEnableOption "Homeage secrets management";
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      age
    ];

    homeage.identityPaths = [ "${config.home.homeDirectory}/.age/key.txt" ];
  };
}
