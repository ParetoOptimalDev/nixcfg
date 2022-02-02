{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.desktop.xmonad;

  colors = {
    magenta = "#FF79C6";
    blue = "#0080FF";
    white = "#F8F8F2";
    yellow = "#F1FA8C";
    orange = "#FF7F00";
    red = "#FF5555";
    lowWhite = "#BBBBBB";
    grey = "#5F5F5F";
  };

  dmenuPatched = pkgs.dmenu.override {
    patches = builtins.map builtins.fetchurl [
      {
        url = "https://tools.suckless.org/dmenu/patches/line-height/dmenu-lineheight-5.0.diff";
        sha256 = "1dllfy9yznjcq65ivwkd77377ccfry72jmy3m77ms6ns62x891by";
      }
    ];
  };

in

{
  options = {
    custom.roles.desktop.xmonad = {
      enable = mkEnableOption "Xmonad window manager";
    };
  };

  config = mkIf cfg.enable {
    custom.roles.desktop = {
      dunst.enable = true;
      picom.enable = true;
    };

    home = {
      packages = with pkgs; [
        # Screenshots
        scrot

        # Menu
        dmenuPatched

        # Locker
        i3lock-pixeled

        # Fonts
        nerdfonts
      ];
    };

    programs.xmobar = import ./xmobar.nix {
      inherit pkgs;
      inherit colors;
    };

    services = {
      trayer = {
        enable = true;
        settings = {
          edge = "top";
          align = "right";
          SetDockType = true;
          SetPartialStrut = true;
          expand = true;
          width = 5;
          transparent = true;
          tint = "0x${builtins.substring 1 6 colors.grey}";
          height = 22;
        };
      };
    };

    xsession.windowManager.xmonad = import ./xmonad.nix {
      inherit lib;
      inherit pkgs;
      inherit colors;
    };
  };
}
