{ pkgs, ... }:

with pkgs;

{
  imports = [
    ../dunst
  ];

  home = {
    packages = with pkgs; [
      # Screenshots
      scrot

      # Menu
      dmenu

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

  services.trayer = {
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

  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = writeText "xmonad.hs" (import ./conf/xmonad.hs.nix);
    extraPackages = with pkgs.haskellPackages; haskellPackages: [ xmobar ];
  };
}
