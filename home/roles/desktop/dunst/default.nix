{ pkgs, ... }:

{
  home.packages = with pkgs; [
    libnotify
    nerdfonts
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "VictorMono Nerd Font Regular 11";
        markup = "yes";
        plan_text = "no";
        format = "<b>%s %p</b>\n%b";
        sort = "no";
        indicate_hidden = "yes";
        alignment = "left";
        bounce_freq = 0;
        show_age_threshold = -1;
        word_wrap = 0;
        ignore_newline = "no";
        stack_duplicates = "yes";
        hide_duplicates_count = "no";
        geometry = "1000x50-10+35";
        shrink = "yes";
        transparency = 5;
        idle_threshold = 2;
        monitor = 0;
        follow = "keyboard";
        sticky_history = "yes";
        history_length = 15;
        show_indicators = "no";
        line_height = 3;
        separator_height = 2;
        padding = 6;
        horizontal_padding = 12;
        separator_color = "frame";
        startup_notification = false;
        dmenu = "${pkgs.dmenu}/dmenu -p dunst:";
        browser = "${pkgs.firefox}/firefox -new-tab";
        icon_position = "left";
        max_icon_size = 80;
        icon_path = "/usr/share/icons/Paper/16x16/mimetypes/:/usr/share/icons/Paper/48x48/status/:/usr/share/icons/Paper/16x16/devices/:/usr/share/icons/Paper/48x48/notifications/:/usr/share/icons/Paper/48x48/emblems/";
        frame_width = 2;
        frame_color = "#8EC07C";
      };
      shortcuts = {
        close = "ctrl+space";
        close_all = "ctrl+shift+space";
        context = "ctrl+shift+period";
      };
      urgency_low = {
        frame_color = "#3B7C87";
        foreground = "#3B7C87";
        background = "#191311";
        timeout = 4;
      };
      urgency_normal = {
        frame_color = "#5B8234";
        foreground = "#5B8234";
        background = "#191311";
        timeout = 6;
      };
      urgency_critical = {
        frame_color = "#B7472A";
        foreground = "#B7472A";
        background = "#191311";
        timeout = 8;
      };
    };
  };
}
