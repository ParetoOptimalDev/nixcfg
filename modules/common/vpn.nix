{ config, pkgs, ... }:

let

  username = import ../../username.nix;

in

{
  services.openvpn.servers.home = {
    autoStart = false;
    config = "config /home/${username}/.accounts/home/ovpn/${username}.ovpn";
    updateResolvConf = true;
  };
}

