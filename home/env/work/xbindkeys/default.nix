{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Backlight control
    xorg.xbacklight
    kbdlight

    # Display control
    grobi

    xbindkeys
  ];

  xdg.configFile."xbindkeysrc" = {
    text = ''
      "xbacklight -10"
        XF86MonBrightnessDown

      "xbacklight +10"
        XF86MonBrightnessUp

      "kbdlight down 50"
        XF86KbdBrightnessDown

      "kbdlight up 50"
        XF86KbdBrightnessUp

      "grobi update"
        XF86Display
    '';
    target = config.home.homeDirectory + "/.xbindkeysrc";
  };
}
