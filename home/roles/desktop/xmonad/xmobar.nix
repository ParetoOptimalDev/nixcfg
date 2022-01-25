{ pkgs, colors, ... }:

let

  colorScheme = {
    foregroundColor = colors.white;
    backgroundColor = colors.grey;
    accentColor = colors.orange;
    warnColor = colors.red;
  };

in

with colorScheme;

{
  enable = true;
  extraConfig =
    let
      sep = "<fc=${accentColor}>•</fc>";
    in
    ''
      Config { overrideRedirect = False
             , font     = "xft:VictorMono Nerd Font:style=SemiBold:pixelsize=14:antialias=true"
             , alpha    = 128
             , bgColor  = "${backgroundColor}"
             , fgColor  = "${foregroundColor}"
             , position = TopW L 95
             , textOffset = 16
             , commands = [ Run WeatherX "LSZB"
                              [ ("clear", "\xe30d")
                              , ("sunny", "\xe30d")
                              , ("mostly clear", "\xe30c")
                              , ("mostly sunny", "\xe30c")
                              , ("partly sunny", "\xe30c")
                              , ("partly cloudy", "\xe30c")
                              , ("mostly cloudy", "\xe302")
                              , ("fair", "\xe32b")
                              , ("obscured","\xe311")
                              , ("overcast","\xe311")
                              , ("cloudy","\xe312")
                              , ("considerable cloudiness", "\xe313")
                              ]
                              [ "-t", "<skyConditionS>  <skyCondition> <tempC>°"
                              ] 9000
                          , Run Cpu
                              [ "-t", "  <total>%"
                              , "-L", "3", "-H", "50"
                              , "-h", "${warnColor}"
                              ] 10
                          , Run MultiCoreTemp
                              [ "-t", "\xf2c8 <avg>°"
                              , "-L", "40", "-H", "60"
                              , "-h", "${warnColor}"
                              ] 50
                          , Run Wireless "wlp82s0"
                              [ "-t", "\xfaa8 <quality>"
                              , "-S", "True"
                              , "-x", "\xfaa9"
                              , "-L", "50"
                              , "-l", "${warnColor}"
                              ] 20
                          , Run Alsa "default" "Master"
                              [ "-t", "<volumestatus>"
                              , "-S", "True"
                              , "--"
                              , "--alsactl", "${pkgs.alsa-utils}/bin/alsactl"
                              , "--on", "", "--off", "<fc=${warnColor}>\xfc5d</fc>"
                              , "--onc", "${foregroundColor}"
                              , "-l", "\xfa7e ", "-m", "\xfa7f ", "-h", "\xfa7d "
                              ]
                          , Run Alsa "default" "Capture"
                              [ "-t", "<volumestatus>"
                              , "-S", "True"
                              , "--"
                              , "--alsactl", "${pkgs.alsa-utils}/bin/alsactl"
                              , "--on", "\xf86b ", "--off", "<fc=${warnColor}>\xf86c</fc>"
                              , "--onc", "${foregroundColor}"
                              ]
                          , Run Battery
                              [ "-t", "<acstatus><watts> (<left>%)"
                              , "-L", "10", "-H", "80"
                              , "-p", "3"
                              , "--"
                              , "-O", "<fc=green>On</fc> - "
                              , "-i", ""
                              , "-L", "-15"
                              , "-H", "-5"
                              , "-l", "${warnColor}"
                              , "--lows"   , "<fn=1>\62020</fn>  "
                              , "--mediums", "<fn=1>\62018</fn>  "
                              , "--highs"  , "<fn=1>\62016</fn>  "
                              ] 10
                          , Run Memory
                              [ "-t", "  <usedratio>%"
                              ] 10
                          , Run DiskU
                              [ ("/", "\xf0a0 <usedp>%")
                              ]
                              [ "-L", "20", "-H", "90"
                              , "-h", "${warnColor}"
                              , "-m", "1"
                              , "-p", "3"
                              ] 20
                          , Run Date "\xe385 %a %b %-d %H:%M" "date" 10
                          , Run StdinReader
                          ]
             , sepChar  = "%"
             , alignSep = "}{"
             , template = " <fc=#6586c8></fc>  %StdinReader% }{ %alsa:default:Master% ${sep} %alsa:default:Capture% ${sep} %cpu% ${sep} %memory% ${sep} %disku% ${sep} %multicoretemp% ${sep} %wlp82s0wi% ${sep} %battery% ${sep} %LSZB% ${sep} %date% "
             }
    '';
}
