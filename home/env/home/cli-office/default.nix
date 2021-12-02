{ config, ... }:

{
  xdg.configFile."khal/config".text = ''
    [calendars]

    [[private]]
    path = ${config.xdg.dataHome}/calendars/nextcloud/personal
    color = dark red

    [default]
    highlight_event_days = True
    default_calendar = private
  '';
}
