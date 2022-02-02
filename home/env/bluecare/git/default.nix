{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.bluecare.git;

in

{
  options = {
    custom.env.bluecare.git = {
      enable = mkEnableOption "Git config";
    };
  };

  config = mkIf cfg.enable {
    programs = {
      git = {
        userEmail = "christian.harke@bluecare.ch";
      };
      ssh.matchBlocks = {
        "code.bluecare.ch" = {
          user = "git";
          extraOptions = {
            PubkeyAcceptedAlgorithms = "+ssh-rsa";
            HostkeyAlgorithms = "+ssh-rsa";
          };
        };
      };
    };
  };
}
