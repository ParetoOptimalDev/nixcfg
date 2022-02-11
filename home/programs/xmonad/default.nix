{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.programs.xmonad;

in

{
  options = {
    custom.programs.xmonad = {
      enable = mkEnableOption "Xmonad window manager";

      colorScheme = {
        foreground = mkOption {
          type = types.str;
          default = "#BBBBBB";
        };

        background = mkOption {
          type = types.str;
          default = "#000000";
        };

        base = mkOption {
          type = types.str;
          default = "#6586c8";
        };

        accent = mkOption {
          type = types.str;
          default = "#FF7F00";
        };

        warn = mkOption {
          type = types.str;
          default = "#FF5555";
        };
      };

      font = {
        package = mkOption {
          type = types.package;
          default = pkgs.nerdfonts;
          description = "Font derivation";
        };

        config = mkOption {
          type = types.str;
          default = "VictorMono Nerd Font:style=SemiBold:pixelsize=14:antialias=true";
          description = "Font config";
        };
      };

      dmenu = {
        package = mkOption {
          type = types.package;
          default = pkgs.dmenu;
          description = "dmenu derivation";
        };

        runCmd = mkOption {
          type = types.str;
          default = "${pkgs.dmenu}/bin/dmenu_run";
          description = "Command to run dmenu";
        };
      };

      locker = {
        package = mkOption {
          type = types.package;
          default = pkgs.i3lock;
          description = "Locker util";
        };

        lockCmd = mkOption {
          type = types.str;
          default = "${pkgs.i3lock}/bin/i3lock";
          description = "Command for locking screen";
        };
      };

      screenshot = {
        package = mkOption {
          type = types.package;
          default = pkgs.scrot;
          description = "Screenshot util";
        };

        runCmd = mkOption {
          type = types.str;
          default = "${pkgs.scrot}/bin/scrot -s";
          description = "Command for taking screenshots";
        };
      };

      xmobar = {
        enable = mkEnableOption "Xmobar";
        mobile = mkEnableOption "Enable additional mobile monitors";
      };
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        cfg.dmenu.package
        cfg.font.package
        cfg.screenshot.package
      ];
    };

    programs.xmobar = {
      enable = cfg.xmobar.enable;
      extraConfig = import ./xmobar.hs.nix { inherit lib pkgs cfg; };
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
          tint = "0x${builtins.substring 1 6 cfg.colorScheme.background}";
          height = 22;
        };
      };
    };

    xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = import ./xmonad.hs.nix { inherit lib pkgs cfg; };
      extraPackages = mkIf cfg.xmobar.enable (with pkgs.haskellPackages; haskellPackages: [ xmobar ]);
    };
  };
}
