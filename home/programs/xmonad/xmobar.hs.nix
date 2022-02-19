{ lib, pkgs, cfg }:

with lib;

let

  sep = "<fc=${cfg.colorScheme.accent}>•</fc>";

in

''
    Config { overrideRedirect = False
           , font     = "xft:${cfg.font.xft}"
           , alpha    = 254
           , bgColor  = "${cfg.colorScheme.background}"
           , fgColor  = "${cfg.colorScheme.foreground}"
           , position = TopW L 95
           , textOffset = 16
           , commands = [ Run WeatherX "LSZB"
                            [ ("clear", "\xe30d ")
                            , ("sunny", "\xe30d ")
                            , ("fair", "\xe38d ")
                            , ("mostly clear", "\xe30c ")
                            , ("mostly sunny", "\xe30c ")
                            , ("partly cloudy", "\xe302 ")
                            , ("partly sunny", "\xe302 ")
                            , ("mostly cloudy", "\xe309 ")
                            , ("obscured","\xe311 ")
                            , ("overcast","\xe311 ")
                            , ("cloudy","\xe312 ")
                            , ("considerable cloudiness", "\xe319 ")
                            , ("", "unknown")
                            ]
                            [ "-t", "<skyConditionS> <tempC>°"
                            ] 9000
                        , Run Cpu
                            [ "-t", "  <total>%"
                            , "-L", "3", "-H", "50"
                            , "-h", "${cfg.colorScheme.warn}"
                            ] 10
                        , Run MultiCoreTemp
                            [ "-t", "\xf2c8 <avg>°"
                            , "-L", "40", "-H", "60"
                            , "-h", "${cfg.colorScheme.warn}"
                            ] 50
                        , Run Alsa "default" "Master"
                            [ "-t", "<volumestatus>"
                            , "-S", "True"
                            , "--"
                            , "--alsactl", "${pkgs.alsa-utils}/bin/alsactl"
                            , "--on", "", "--off", "<fc=${cfg.colorScheme.warn}>\xfc5d</fc>"
                            , "--onc", "${cfg.colorScheme.foreground}"
                            , "-l", "\xfa7e ", "-m", "\xfa7f ", "-h", "\xfa7d "
                            ]
                        , Run Alsa "default" "Capture"
                            [ "-t", "<volumestatus>"
                            , "-S", "True"
                            , "--"
                            , "--alsactl", "${pkgs.alsa-utils}/bin/alsactl"
                            , "--on", "\xf86b ", "--off", "<fc=${cfg.colorScheme.warn}>\xf86c</fc>"
                            , "--onc", "${cfg.colorScheme.foreground}"
                            ]
                        , Run Memory
                            [ "-t", "  <usedratio>%"
                            ] 10
                        , Run DiskU
                            [ ("/", "\xf0a0 <free>")
                            ]
                            [ "-L", "20", "-H", "90"
                            , "-h", "${cfg.colorScheme.warn}"
                            , "-m", "1"
                            , "-p", "3"
                            ] 20
                        , Run Date "\xe385 %a %b %-d %H:%M" "date" 10
                        , Run StdinReader
  ${optionalString cfg.xmobar.mobile ''

                          -- Mobile monitors
                          , Run Battery
                              [ "-t", "<acstatus><left>"
                              , "-S", "True"
                              , "-L", "10", "-H", "80"
                              , "-p", "3"
                              , "--"
                              , "-O", "\xfba3"
                              , "-i", ""
                              , "-o", ""
                              , "-L", "-15" , "-H", "-5"
                              , "-l", "${cfg.colorScheme.warn}"
                              , "--lows"   , "\xf579"
                              , "--mediums", "\xf57d"
                              , "--highs"  , "\xf578"
                              ] 10''}
                        ]
           , sepChar  = "%"
           , alignSep = "}{"
           , template = " <fc=${cfg.colorScheme.base}></fc>  %StdinReader% }{ %alsa:default:Master% ${sep} %alsa:default:Capture% ${sep} %cpu% ${sep} %memory% ${sep} %disku% ${sep} %multicoretemp% ${sep} ${optionalString cfg.xmobar.mobile "%battery% ${sep} "}%LSZB% ${sep} %date% "
           }
''
