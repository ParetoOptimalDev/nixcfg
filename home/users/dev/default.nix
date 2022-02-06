{ config, lib, ... }:

with lib;

let

  cfg = config.custom.users.dev;

in

{
  options = {
    custom.users.dev = {
      enable = mkEnableOption "User config";
    };
  };

  config = mkIf cfg.enable {
    home.username = "dev";

    custom = {
      users.christian = {
        git.enable = true;
        shell.enable = true;
        vim.enable = true;
      };
    };
  };
}
