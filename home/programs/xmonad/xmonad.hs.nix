{ lib, pkgs, cfg, ... }:

with lib;

let

  escapeHaskellString = arg: replaceStrings [ "\"" ] [ "\\\"" ] (toString arg);

  /* Create a fixed width string with additional prefix to match
    required width.
    This function will fail if the input string is longer than the
    requested length.
    Type: fixedWidthString :: int -> string -> string -> string
    Example:
    fixedWidthString 5 "0" (toString 15)
    => "15000"
  */
  fixedWidthString = width: filler: str:
    let
      strw = stringLength str;
      reqWidth = width - (stringLength filler);
    in
    assert assertMsg (strw <= width)
      "fixedWidthString: requested string length (${
          toString width}) must not be shorter than actual length (${
            toString strw})";
    if strw == width then str else fixedWidthString reqWidth filler str + filler;

  mkAutorun = n: v: "spawnOnOnce \"${toString v}\" \"${n}\"";

  mkXmobarColor = n: v: ''
    ${fixedWidthString 10 " " n} = xmobarColor "${v}" ""
  '';

in

pkgs.writeText "xmonad.hs" ''
  import Control.Monad (join, when)
  import Data.Maybe (maybeToList)

  import XMonad

  import XMonad.Hooks.DynamicLog
  import XMonad.Hooks.EwmhDesktops
  import XMonad.Hooks.ManageDocks
  import XMonad.Hooks.ManageHelpers

  import XMonad.Layout.Magnifier
  import XMonad.Layout.NoBorders
  import XMonad.Layout.Renamed
  import XMonad.Layout.Spacing
  import XMonad.Layout.ThreeColumns

  import XMonad.Util.EZConfig
  import XMonad.Util.Loggers
  import XMonad.Util.NamedScratchpad
  import XMonad.Util.SpawnOnce
  import XMonad.Util.Ungrab

  import qualified XMonad.StackSet as W

  myModMask :: KeyMask
  myModMask = ${cfg.modKey}Mask

  myTerminal :: String
  myTerminal = "alacritty"

  myScratchpads :: [NamedScratchpad]
  myScratchpads =
    [ NS "terminal" spawnTerm findTerm manageTerm
    , NS "htop" spawnHtop findHtop manageHtop
    , NS "pavucontrol" spawnPavuCtl findPavuCtl managePavuCtl
    ]
    where
      center :: Rational -> Rational
      center (ratio) = (1 - ratio)/2
      spawnTerm      = myTerminal ++ " -t scratchpad"
      findTerm       = title =? "scratchpad"
      manageTerm     = customFloating $ W.RationalRect x y w h
        where
          w = (4/5)
          h = (5/6)
          x = center w
          y = center h
      spawnHtop     = myTerminal ++ " -t htop -e htop"
      findHtop      = title =? "htop"
      manageHtop    = customFloating $ W.RationalRect x y w h
        where
          w = (2/3)
          h = (2/3)
          x = center w
          y = center h
      spawnPavuCtl  = "pavucontrol"
      findPavuCtl   = className =? "Pavucontrol"
      managePavuCtl = customFloating $ W.RationalRect x y w h
        where
          w = (2/3)
          h = (2/3)
          x = center w
          y = center h

  main :: IO ()
  main = xmonad
       . ewmh
     =<< statusBar "xmobar" myXmobarPP toggleStrutsKey myConfig
    where
      toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
      toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

  myConfig = def
      { modMask         = myModMask          -- Rebind Mod key
      , terminal        = myTerminal
      , borderWidth = 2
      , normalBorderColor = "${cfg.colorScheme.foreground}"
      , focusedBorderColor = "${cfg.colorScheme.base}"
      , layoutHook      = myLayout           -- Use custom layouts
      , manageHook      = myManageHook       -- Match on certain windows
      ${optionalString (cfg.autoruns != {})
        ", startupHook     = myStartupHook >> addEWMHFullscreen"}
      , handleEventHook = fullscreenEventHook
      }
    `additionalKeysP`
      [ ("M-S-<Delete>", spawn "${escapeHaskellString cfg.locker.lockCmd}")
      , ("M-S-s", unGrab *> spawn "${escapeHaskellString cfg.screenshot.runCmd}")
      , ("M-p"  , spawn "${escapeHaskellString cfg.dmenu.runCmd}")

      -- ScratchPads
      , ("M-C-<Return>", namedScratchpadAction myScratchpads "terminal")
      , ("M-C-t", namedScratchpadAction myScratchpads "htop")
      , ("M-C-v", namedScratchpadAction myScratchpads "pavucontrol")
      ]

  manageZoomHook :: ManageHook
  manageZoomHook =
    composeAll $
      [ (className =? zoomClassName) <&&> shouldFloat <$> title --> doFloat,
        (className =? zoomClassName) <&&> shouldSink <$> title --> doSink
      ]
    where
      zoomClassName = "zoom"
      tileTitles =
        [ "Zoom - Free Account", -- main window
          "Zoom - Licensed Account", -- main window
          "Zoom", -- meeting window on creation
          "Zoom Meeting" -- meeting window shortly after creation
        ]
      shouldFloat title = title `notElem` tileTitles
      shouldSink title = title `elem` tileTitles
      doSink = (ask >>= doF . W.sink) <+> doF W.swapDown

  myManageHook :: ManageHook
  myManageHook = manageZoomHook <+> composeAll
      -- Workspace assignments
      [ className =? "jetbrains-idea"             --> doShift "2"
      , className =? "Firefox"                    --> doShift "3"
      , className =? "Microsoft Teams - Preview"  --> doShift "4"
      , className =? "Signal"                     --> doShift "4"
      , className =? "Slack"                      --> doShift "4"
      , className =? "TelegramDesktop"            --> doShift "4"
      , className =? "zoom"                       --> doShift "4"
      , className =? "Chromium-browser"           --> doShift "5"
      , className =? "Thunderbird"                --> doShift "5"
      , className =? "VirtualBox"                 --> doShift "6"
      , className =? "VirtualBox Machine"         --> doShift "6"
      , className =? "VirtualBox Manager"         --> doShift "6"
      , className =? "xfreerdp"                   --> doShift "6"
      , className =? "Steam"                      --> doShift "8"
      , className =? "TeamSpeak 3"                --> doShift "8"
      -- Spotify workspace shift does not work, see:
      -- https://www.reddit.com/r/xmonad/comments/q7i569/spotify_workspace_shift_issue/
      , className =? "Spotify"                    --> doShift "9"

      -- Floating windows
      , isDialog                                            --> doFloat
      , className =? "Gimp"                                 --> doFloat
      , className =? "jetbrains-idea" <&&> title =? "win0"  --> doFloat
      ] <+> namedScratchpadManageHook myScratchpads

  addNETSupported :: Atom -> X ()
  addNETSupported x   = withDisplay $ \dpy -> do
      r               <- asks theRoot
      a_NET_SUPPORTED <- getAtom "_NET_SUPPORTED"
      a               <- getAtom "ATOM"
      liftIO $ do
         sup <- (join . maybeToList) <$> getWindowProperty32 dpy a_NET_SUPPORTED r
         when (fromIntegral x `notElem` sup) $
           changeProperty32 dpy r a_NET_SUPPORTED a propModeAppend [fromIntegral x]

  addEWMHFullscreen :: X ()
  addEWMHFullscreen   = do
      wms <- getAtom "_NET_WM_STATE"
      wfs <- getAtom "_NET_WM_STATE_FULLSCREEN"
      mapM_ addNETSupported [wms, wfs]

  ${optionalString (cfg.autoruns != {}) ''
    myStartupHook = startupHook def <+> do
        ${concatStringsSep "\n    " (mapAttrsToList mkAutorun cfg.autoruns)}
  ''}
  myLayout = smartBorders $ spacingWithEdge 5 $ tiled ||| Mirror tiled ||| Full ||| threeCol
    where
      threeCol = renamed [Replace "ThreeCol"]
          $ magnifiercz' 1.3
          $ ThreeColMid nmaster delta ratio
      tiled    = Tall nmaster delta ratio
      nmaster  = 1      -- Default number of windows in the master pane
      ratio    = 1/2    -- Default proportion of screen occupied by master pane
      delta    = 3/100  -- Percent of screen to increment by when resizing panes

  myXmobarPP :: PP
  myXmobarPP = def
      { ppSep             = accent " • "
      , ppTitleSanitize   = xmobarStrip
      , ppCurrent         = wrap (accent "[") (accent "]")
      , ppHidden          = base . wrap " " " "
      , ppHiddenNoWindows = foreground . wrap " " " "
      , ppUrgent          = warn . wrap "!" "!"
      }
    where
      ${concatStringsSep ", " (mapAttrsToList (n: v: toString n)  cfg.colorScheme)} :: String -> String
      ${concatStringsSep "    " (mapAttrsToList mkXmobarColor cfg.colorScheme)}
''
