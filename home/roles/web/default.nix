{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.custom.roles.web;

in

{
  options = {
    custom.roles.web = {
      enable = mkEnableOption "Web";
    };
  };

  config = mkIf cfg.enable {
    custom.roles.web.nextcloud-client.enable = true;

    home.packages = with pkgs; [
      _1password
      _1password-gui
      bind
      wget
      thunderbird

      # Messengers
      signal-desktop
      tdesktop # Telegram
    ];

    programs = {
      chromium.enable = true;
      firefox = {
        enable = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          facebook-container
          i-dont-care-about-cookies
          header-editor
          languagetool
          multi-account-containers
          onepassword-password-manager
          react-devtools
          ublock-origin
          vim-vixen
          vue-js-devtools
        ];
        profiles."ztbvdcs8.default" = {
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "https://harke.ch/dash/home/";
          };
          userChrome = ''
            /* Workaround for vim-vixen issue
             * https://github.com/ueokande/vim-vixen/issues/1424
             */
            .vimvixen-console-frame {
              height: 0px;
              color-scheme: light !important;
            }
          '';
          userContent = ''
            /* Workaround for vim-vixen issue
             * https://github.com/ueokande/vim-vixen/issues/1424
             */
            .vimvixen-console-frame {
              height: 0px;
              color-scheme: light !important;
            }
          '';
        };
      };
    };
  };
}
