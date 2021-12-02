{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    khard
    offlineimap
  ];

  xdg.configFile = {
    "khal/config".text = ''
      [calendars]

      [[work]]
      path = ${config.xdg.configHome}/calendars/bluecare/calendar
      color = dark blue

      [default]
      default_calendar = work
    '';
    "khard/khard.conf".source = ./config/khard/khard.conf;
    "mutt/muttrc".source = ./config/mutt/muttrc;
    "offlineimap/config".source = ./config/offlineimap/config;
    "offlineimap/offlineimap.py".source = ./config/offlineimap/offlineimap.py;
    "vdirsyncer/config".text = ''
      # CARDDAV

      [pair bc_contacts]
      a = "bc_contacts_local"
      b = "bc_contacts_remote"
      collections = ["from a", "from b"]
      #metadata = ["displayname", "color"]
      conflict_resolution = "b wins"

      [storage bc_contacts_local]
      type = "filesystem"
      path = "~/.contacts/bluecare"
      fileext = ".vcf"

      [storage bc_contacts_remote]
      type = "carddav"
      read_only = true
      url = "http://localhost:1080/users/christian.harke@bluecare.ch/contacts/"
      username.fetch = ["command", "~/.accounts/bluecare/get_user.sh"]
      password.fetch = ["command", "~/.accounts/bluecare/get_pass.sh"]


      # CALDAV

      [pair bc_calendar]
      a = "bc_calendar_local"
      b = "bc_calendar_remote"
      collections = ["from a", "from b"]
      metadata = ["displayname", "color"]
      conflict_resolution = "b wins"

      [storage bc_calendar_local]
      type = "filesystem"
      path = "~/.calendars/bluecare"
      fileext = ".ics"

      [storage bc_calendar_remote]
      type = "caldav"
      read_only = true
      url = "http://localhost:1080/users/christian.harke@bluecare.ch/calendar/"
      username.fetch = ["command", "~/.accounts/bluecare/get_user.sh"]
      password.fetch = ["command", "~/.accounts/bluecare/get_pass.sh"]
    '';
  };
}
