{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.users.christian.office.cli;

  calendarsPath = "${config.xdg.dataHome}/calendars";

  inherit (config.custom.roles.homeage) secretsPath;
  secretUrl = "vdirsyncer_nextcloud_url";
  secretUsername = "vdirsyncer_nextcloud_username";
  secretPassword = "vdirsyncer_nextcloud_password";

in

{
  options = {
    custom.users.christian.office.cli = {
      enable = mkEnableOption "CLI office config";
    };
  };

  config = mkIf cfg.enable {
    custom.roles = {
      homeage.secrets = [
        secretUrl
        secretUsername
        secretPassword
      ];

      office.cli = {
        vdirsyncer.extraConfig = ''
          # CALDAV HOME

          [pair nextcloud_calendar]
          a = "nextcloud_calendar_local"
          b = "nextcloud_calendar_remote"
          collections = ["personal"]
          metadata = ["displayname", "color"]

          [storage nextcloud_calendar_local]
          type = "filesystem"
          path = "${calendarsPath}/nextcloud"
          fileext = ".ics"

          [storage nextcloud_calendar_remote]
          type = "caldav"
          url.fetch = ["command", "${pkgs.coreutils}/bin/cat", "${secretsPath}/${secretUrl}"]
          username.fetch = ["command", "${pkgs.coreutils}/bin/cat", "${secretsPath}/${secretUsername}"]
          password.fetch = ["command", "${pkgs.coreutils}/bin/cat", "${secretsPath}/${secretPassword}"]
        '';
      };
    };
  };
}
