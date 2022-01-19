{ pkgs, ... }:

let

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
  imports = [
    ../dunst
  ];

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

  programs.xmobar = {
    enable = true;
    extraConfig = import ./conf/xmobarrc.nix;
  };

  services = {
    picom = import ../picom;
    trayer = {
      enable = true;
      settings = {
        edge = "top";
        align = "right";
        SetDockType = true;
        SetPartialStrut = true;
        expand = true;
        width = 10;
        transparent = true;
        tint = "0x5f5f5f";
        height = 22;
      };
    };
  };

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = pkgs.writeText "xmonad.hs" (import ./conf/xmonad.hs.nix);
    extraPackages = with pkgs.haskellPackages; haskellPackages: [ xmobar ];
  };
}
