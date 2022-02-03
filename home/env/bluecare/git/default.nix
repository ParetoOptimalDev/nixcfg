{ config, lib, ... }:

with lib;

let

  bluecareCfg = config.custom.env.bluecare;
  cfg = bluecareCfg.git;

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
        inherit (bluecareCfg) userEmail;
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
