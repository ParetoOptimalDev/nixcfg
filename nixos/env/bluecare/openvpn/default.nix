{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.bluecare.openvpn;
  bluecareCfg = config.custom.env.bluecare;

  ovpnConfig = "ovpn-bluecare-christian-config";
  ovpnCredentials = "ovpn-bluecare-christian-credentials";

in

{
  options = {
    custom.env.bluecare.openvpn = {
      enable = mkEnableOption "OpenVPN client" // { enable = true; };

      autoStart = mkOption {
        type = types.bool;
        default = false;
        description = "Start service together with the computer";
      };
    };
  };

  config = mkIf cfg.enable {
    custom.base.agenix.secrets = [ ovpnConfig ovpnCredentials ];

    services = {
      openvpn.servers.bluecare = {
        inherit (cfg) autoStart;
        config = ''
          config ${config.age.secrets.${ovpnConfig}.path}
          auth-user-pass ${config.age.secrets.${ovpnCredentials}.path}
        '';
        updateResolvConf = true;
      };
    };
  };
}
