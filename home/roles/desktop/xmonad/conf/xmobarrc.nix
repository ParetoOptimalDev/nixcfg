''
  Config { overrideRedirect = False
         , font     = "xft:VictorMono Nerd Font:style=SemiBold:pixelsize=14:antialias=true"
         , additionalFonts  = ["xft:FontAwesome-9"]
         , alpha    = 128
         , bgColor  = "#5f5f5f"
         , fgColor  = "#f8f8f2"
         , position = TopW L 90
         , commands = [ Run Weather "EGPF"
                          [ "--template", "<weather> <tempC>°C"
                          , "-L", "0"
                          , "-H", "25"
                          , "--low"   , "lightblue"
                          , "--normal", "#f8f8f2"
                          , "--high"  , "red"
                          ] 36000
                      , Run Cpu
                          [ "-L", "3"
                          , "-H", "50"
                          , "--high"  , "red"
                          , "--normal", "green"
                          ] 10
                      , Run Alsa "default" "Master"
                          [ "--template", "<volumestatus>"
                          , "--suffix"  , "True"
                          , "--"
                          , "--on", ""
                          ]
                      , Run Battery
                          [ "-t", "<acstatus><watts> (<left>%)"
                          , "-L", "10", "-H", "80", "-p", "3"
                          , "--", "-O", "<fc=green>On</fc> - ", "-i", ""
                          , "-L", "-15", "-H", "-5"
                          , "-l", "red", "-m", "blue", "-h", "green"
                          , "--lows"   , "<fn=1>\62020</fn>  "
                          , "--mediums", "<fn=1>\62018</fn>  "
                          , "--highs"  , "<fn=1>\62016</fn>  "
                          ] 10
                      , Run Memory ["--template", "Mem: <usedratio>%"] 10
                      , Run Swap [] 10
                      , Run Date "%a %Y-%m-%d <fc=#8be9fd>%H:%M</fc>" "date" 10
                      , Run StdinReader
                      ]
         , sepChar  = "%"
         , alignSep = "}{"
         , template = "%StdinReader% }{ %alsa:default:Master% | %cpu% | %memory% * %swap% | %battery% | %EGPF% | %date% "
         }
''
