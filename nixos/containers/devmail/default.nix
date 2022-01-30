{ config, lib, ... }:

with lib;

let

  cfg = config.custom.containers.devmail;

in

{
  options = {
    custom.containers.devmail = {
      enable = mkEnableOption "Devmail container";

      primaryHostname = mkOption {
        type = types.str;
        default = "devmail";
        description = "Host name of the container for local address resolution.";
      };

      localDomains = mkOption {
        type = with types; listOf str;
        default = [ "test.com" ];
        description = "List of domains to be served by the mail server.";
      };

      hostAddress = mkOption {
        type = types.str;
        default = "10.231.2.1";
        description = "Host address";
      };

      localAddress = mkOption {
        type = types.str;
        default = "10.231.2.2";
        description = "Local address";
      };

      autoStart = mkOption {
        type = types.bool;
        default = false;
        description = "Start container together with the computer";
      };
    };
  };

  config = mkIf cfg.enable {
    containers.devmail = {
      inherit (cfg) hostAddress localAddress autoStart;
      config = {
        imports = [ (config.lib.custom.mkNixosPath "/dev/devmail") ];
        config.custom.dev.devmail = {
          inherit (cfg) primaryHostname localDomains;
          enable = true;
        };
      };
      privateNetwork = true;
    };

    networking.extraHosts = ''
      ${cfg.localAddress} ${cfg.primaryHostname}
    '';
  };
}
