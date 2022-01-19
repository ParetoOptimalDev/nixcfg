{ config, pkgs, ... }:

let

  username = import ../../username.nix;

in

{
  imports =
    [
      ./hardware
      ../../modules/common
      ../../modules/container.nix
      ../../modules/mobile.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "n75";

  fileSystems =
    let
      target = "/mnt/bluecare";
      fileserver = "bluecare-s54";
      fsType = "cifs";
      credentials = "/home/${username}/.accounts/bluecare/smbcredentials";
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

  #  hardware.printers =
  #  let
  #    credentials = "${acc.domain}\\${acc.username}:${acc.password}";
  #    printserver = "bluecare-s20";
  #    location = "BlueCare";
  #    description = "Kyocera TASKalfa 300ci";
  #    model = "Kyocera/Kyocera_TASKalfa_300ci.ppd";
  #  in
  #  {
  #    ensurePrinters = [
  #      {
  #        name = "FollowMe";
  #        location = location;
  #        description = description;
  #        deviceUri = "smb://${credentials}@${printserver}/FollowMe";
  #        model = model;
  #      }
  #      {
  #        name = "FollowMe_Color";
  #        location = location;
  #        description = "${description} Color";
  #        deviceUri = "smb://${credentials}@${printserver}/FollowMe%20Color";
  #        model = model;
  #      }
  #    ];
  #    ensureDefaultPrinter = "FollowMe";
  #  };

  services = {
    openvpn.servers.bluecare = {
      autoStart = false;
      config = "config /home/${username}/.accounts/bluecare/ovpn/chr@vpfwblue.bluecare.ch.ovpn";
      updateResolvConf = true;
    };

    #    printing.drivers = [ pkgs.cups-kyodialog3 ];
  };

  containers.devmail =
    {
      config = { config, pkgs, ... }:
        {
          imports = [ ../../modules/devmail.nix ];
          services.devmail = {
            enable = true;
            primaryHostname = "devmail";
            localDomains = [ "hin.ch" "test.com" ];
          };
        };
      privateNetwork = true;
      hostAddress = "10.231.2.1";
      localAddress = "10.231.2.2";
      autoStart = false;
    };
  networking.extraHosts = ''
    10.231.2.2 devmail
  '';
}
