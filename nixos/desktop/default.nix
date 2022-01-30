{ config, lib, pkgs, ... } @ args:

with lib;

let

  cfg = config.custom.desktop;

  subModules = [
    (import ./direnv.nix)
    (import ./input.nix args)
    (import ./printing.nix args)
    (import ./sound.nix args)
    (mkIf cfg.gaming (import ./gaming.nix))
    (mkIf cfg.mobile (import ./mobile.nix))
  ];

in

{
  options = {
    custom.desktop = {
      enable = mkEnableOption "Desktop computer config";
      gaming = mkEnableOption "Gaming computer config";
      mobile = mkEnableOption "Mobile computer config";
    };
  };

  config = mkIf cfg.enable (mkMerge ([
    {
      services = {
        xserver = {
          enable = true;
          desktopManager.xterm.enable = true;
        };
      };
    }
  ] ++ subModules));
}
