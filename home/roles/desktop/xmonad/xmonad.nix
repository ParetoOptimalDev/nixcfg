{ lib, pkgs, colors, ... }:

with lib;
with builtins;

let

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
      strw = lib.stringLength str;
      reqWidth = width - (lib.stringLength filler);
    in
    assert lib.assertMsg (strw <= width)
      "fixedWidthString: requested string length (${
          toString width}) must not be shorter than actual length (${
            toString strw})";
    if strw == width then str else fixedWidthString reqWidth filler str + filler;

  mkXmobarColor = n: v: ''
    ${fixedWidthString 8 " " n} = xmobarColor "${v}" ""
  '';

in

{
  enable = true;
  enableContribAndExtras = true;
  config = pkgs.writeText "xmonad.hs" ''
    import XMonad

    import XMonad.Hooks.DynamicLog
    import XMonad.Hooks.ManageDocks
    import XMonad.Hooks.ManageHelpers

    import XMonad.Util.EZConfig
    import XMonad.Util.Loggers
    import XMonad.Util.Ungrab

    import XMonad.Layout.Gaps
    import XMonad.Layout.Magnifier
    import XMonad.Layout.Renamed
    import XMonad.Layout.ThreeColumns

    import XMonad.Hooks.EwmhDesktops

    main :: IO ()
    main = xmonad
         . ewmh
       =<< statusBar "xmobar" myXmobarPP toggleStrutsKey myConfig
      where
        toggleStrutsKey :: XConfig Layout -> (KeyMask, KeySym)
        toggleStrutsKey XConfig{ modMask = m } = (m, xK_b)

    myConfig = def
        { modMask    = mod4Mask      -- Rebind Mod to the Super key
        , terminal = "alacritty"
        , layoutHook = myLayout      -- Use custom layouts
        , manageHook = myManageHook  -- Match on certain windows
        , handleEventHook = fullscreenEventHook
        }
      `additionalKeysP`
        [ ("M-S-<Delete>", spawn "i3lock-pixeled"                                                                  )
        , ("M-S-s", unGrab *> spawn "scrot -s"                                                                     )
        , ("M-p"  , spawn "dmenu_run -fn \"VictorMono Nerd Font:style=SemiBold:pixelsize=14:antialias=true\" -h 22")
        ]

    myManageHook :: ManageHook
    myManageHook = composeAll
        [ className =? "Gimp" --> doFloat
        , isDialog            --> doFloat
        ]

    myLayout = gaps [(U,10), (R,10), (D,10), (L,10)] $ tiled ||| Mirror tiled ||| Full ||| threeCol
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
        { ppSep             = orange " • "
        , ppTitleSanitize   = xmobarStrip
        , ppCurrent         = wrap (orange "[") (orange "]")
        , ppHidden          = white . wrap " " ""
        , ppHiddenNoWindows = lowWhite . wrap " " ""
        , ppUrgent          = red . wrap (yellow "!") (yellow "!")
        }
      where
        ${concatStringsSep ", " ([ ] ++ mapAttrsToList (n: v: toString n)  colors)} :: String -> String
        ${concatStringsSep "    " ([ ] ++ mapAttrsToList mkXmobarColor colors)}
  '';
  extraPackages = with pkgs.haskellPackages; haskellPackages: [ xmobar ];
}
