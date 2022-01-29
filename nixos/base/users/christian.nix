{ lib, pkgs, isEnabled, ... }:

with lib;

let

  username = "christian";

in

mkIf isEnabled {
  fileSystems =
    let
      target = "/mnt/home";
      fileserver = "sv-syno-01";
      fsType = "cifs";
      credentials = "/home/${username}/.accounts/home/smbcredentials";
      automount_opts = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" ];
      auth_opts = [ "uid=1000" "gid=100" "credentials=${credentials}" ];
      options = automount_opts ++ auth_opts;
    in
    {
      "${target}/backup" = {
        device = "//${fileserver}/backup";
        fsType = fsType;
        options = options;
      };

      "${target}/home" = {
        device = "//${fileserver}/home";
        fsType = fsType;
        options = options;
      };

      "${target}/music" = {
        device = "//${fileserver}/music";
        fsType = fsType;
        options = options;
      };

      "${target}/photo" = {
        device = "//${fileserver}/photo";
        fsType = fsType;
        options = options;
      };

      "${target}/public" = {
        device = "//${fileserver}/public";
        fsType = fsType;
        options = options;
      };

      "${target}/video" = {
        device = "//${fileserver}/video";
        fsType = fsType;
        options = options;
      };
    };

  services.openvpn.servers.home = {
    autoStart = false;
    config = "config /home/${username}/.accounts/home/ovpn/${username}.ovpn";
    updateResolvConf = true;
  };

  users.users."${username}" = {
    shell = pkgs.zsh;
    name = username;
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "scanner"
    ];
    initialPassword = "changeme";
    openssh.authorizedKeys.keyFiles = [ ./christian_id_rsa.pub ];
  };
}
