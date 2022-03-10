{ config, lib, ... }:

with lib;

let

  cfg = config.custom.env.bluecare.fileserverMounts;
  bluecareCfg = config.custom.env.bluecare;

  inherit (bluecareCfg) username;
  secret = "smb-bluecare-christian";

in

{
  options = {
    custom.env.bluecare.fileserverMounts = {
      enable = mkEnableOption "File server mounts" // { enable = true; };
    };
  };

  config = mkIf cfg.enable {
    custom.base.agenix.secrets = [ secret ];

    fileSystems =
      let
        target = "/mnt/bluecare";
        fileserver = "bluecare-s54";
        fsType = "cifs";
        credentials = config.age.secrets.${secret}.path;
        automount_opts = [ "x-systemd.automount" "noauto" "x-systemd.idle-timeout=60" "x-systemd.device-timeout=5s" "x-systemd.mount-timeout=5s" ];
        auth_opts = [ "uid=1000" "gid=100" "credentials=${credentials}" ];
        options = automount_opts ++ auth_opts;
      in
      {
        "${target}/home" = {
          device = "//${fileserver}/homeshares$/chr";
          fsType = fsType;
          options = options;
        };

        "${target}/bc_projekte" = {
          device = "//${fileserver}/bc_projekte$";
          fsType = fsType;
          options = options;
        };

        "${target}/bc_produkte_und_systeme$" = {
          device = "//${fileserver}/bc_produkte_und_systeme$";
          fsType = fsType;
          options = options;
        };

        "${target}/bc_bereiche" = {
          device = "//${fileserver}/bc_bereiche$";
          fsType = fsType;
          options = options;
        };

        "${target}/bluecare" = {
          device = "//${fileserver}/bluecare$";
          fsType = fsType;
          options = options;
        };

        "${target}/transfer" = {
          device = "//${fileserver}/transfer";
          fsType = fsType;
          options = options;
        };
      };
  };
}
