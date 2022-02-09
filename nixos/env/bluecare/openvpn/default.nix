{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.bluecare.openvpn;
  bluecareCfg = config.custom.env.bluecare;

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
    services = {
      openvpn.servers.bluecare = {
        inherit (cfg) autoStart;
        config = "config /home/${bluecareCfg.username}/.accounts/bluecare/ovpn/chr@vpfwblue.bluecare.ch.ovpn";
        updateResolvConf = true;
      };
    };
  };
}
