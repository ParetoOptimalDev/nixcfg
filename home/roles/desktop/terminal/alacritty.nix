{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [
      nerdfonts
    ];

    sessionVariables =
      let
        terminal = "alacritty";
      in
      {
        TERMINAL = terminal;
        TERMCMD = terminal;
      };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      opacity = 0.95;
      font =
        let
          fontFamily = "VictorMono Nerd Font Mono";
        in
        {
          normal = {
            family = fontFamily;
            style = "Regular";
          };
          bold = {
            family = fontFamily;
            style = "Bold";
          };
          italic = {
            family = fontFamily;
            style = "Italic";
          };
          bold_italic = {
            family = fontFamily;
            style = "Bold Italic";
          };
          size = 11.5;
        };
      key_bindings = [
        {
          key = "Key0";
          mods = "Control";
          action = "ResetFontSize";
        }
        {
          key = "Numpad0";
          mods = "Control";
          action = "ResetFontSize";
        }
        {
          key = "NumpadAdd";
          mods = "Control";
          action = "IncreaseFontSize";
        }
        {
          key = "NumpadSubtract";
          mods = "Control";
          action = "DecreaseFontSize";
        }
      ];
    };
  };
}
