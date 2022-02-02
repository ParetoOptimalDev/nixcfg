{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.christian;

in

{
  options = {
    custom.users.christian = {
      enable = mkEnableOption "User config";
    };
  };

  config = mkIf cfg.enable {
    home.username = "christian";

    custom = {
      users.christian = {
        bin.enable = true;
        fonts.enable = true;
        git.enable = true;
        hardware = {
          kmonad.enable = true;
          xbindkeys.enable = true;
        };
        shell.enable = true;
        vim.enable = true;
      };
    };
  };
}
