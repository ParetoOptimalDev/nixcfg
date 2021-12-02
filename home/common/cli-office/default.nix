{ config, pkgs, ... }:

with pkgs;

{
  home.packages = [
    # calendar
    khal
    vdirsyncer

    # e-mail
    mutt-with-sidebar
    offlineimap
    urlview
    w3m
  ];

  systemd.user = {
    services = {
      offlineimap-oneshot = {
        Unit = {
          Description = "Offlineimap Service (oneshot)";
          Documentation = [ "man:offlineimap(1)" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${offlineimap}/bin/offlineimap -o -u basic";
          TimeoutStopSec = "2m";
        };
        Install = {
          WantedBy = [ "mail.target" ];
        };
      };

      vdirsyncer-oneshot = {
        Unit = {
          Description = "Synchronize calendars and contacts (oneshot)";
          Documentation = [ "https://vdirsyncer.readthedocs.org/" ];
        };
        Service = {
          Type = "oneshot";
          ExecStart = "${vdirsyncer}/bin/vdirsyncer sync";
        };
      };
    };

    timers = {
      offlineimap-oneshot = {
        Unit = {
          Description = "Offlineimap Query Timer";
        };
        Timer = {
          OnBootSec = "1m";
          OnUnitInactiveSec = "15m";
        };
      };

      vdirsyncer-oneshot = {
        Unit = {
          Description = "Synchronize vdirs";
        };
        Timer = {
          OnBootSec = "5m";
          OnUnitActiveSec = "5m";
          AccuracySec = "5m";
        };
      };
    };

    xdg.configFile = {
      "khal/config".text = ''
        [calendars]

        [[private]]
        path = ~/.calendars/nextcloud/personal
        color = dark red

        [default]
        highlight_event_days = True

        [locale]
        local_timezone = Europe/Zurich
        default_timezone = Europe/Zurich
        timeformat = %H:%M
        dateformat = %d.%m.
        longdateformat = %d.%m.%Y
        datetimeformat = %d.%m. %H:%M
        longdatetimeformat = %d.%m.%Y %H:%M
      '';
      "vdirsyncer/config".text = ''
        [general]
        status_path = "~/.vdirsyncer/status/"

        [pair nextcloud_calendar]
        a = "nextcloud_calendar_local"
        b = "nextcloud_calendar_remote"
        collections = ["personal"]
        metadata = ["displayname", "color"]

        [storage nextcloud_calendar_local]
        type = "filesystem"
        path = "~/.calendars/nextcloud"
        fileext = ".ics"

        [storage nextcloud_calendar_remote]
        type = "caldav"
        url.fetch = ["command", "~/.accounts/get_secret.sh", "home/vdirsyncer_nextcloud", "url"]
        username.fetch = ["command", "~/.accounts/get_secret.sh", "home/vdirsyncer_nextcloud", "username"]
        password.fetch = ["command", "~/.accounts/get_secret.sh", "home/vdirsyncer_nextcloud", "password"]
      '';
      "mutt/.urlview" = {
        source = ./config/mutt/urlview;
        target = config.home.homeDirectory + "/.urlview";
      };
      "mutt/mailcap".source = ./config/mutt/mailcap;
    };
  }
