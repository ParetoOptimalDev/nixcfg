{
  enable = true;
  fade = true;
  fadeDelta = 5;
  fadeExclude = [
    "window_type *= 'menu'"
    #"class_g = 'Firefox' && window_type = 'utility'"
    #"class_g = 'Thunderbird' && window_type = 'utility'"
    "window_type = 'utility'"
  ];
  inactiveOpacity = "0.9";
  opacityRule = [
    "100:_NET_WM_STATE@:32a ~= '_NET_WM_STATE_MAXIMIZED_*'"
    "100:_NET_WM_STATE@:32a *= '_NET_WM_STATE_FULLSCREEN'"
    "100:fullscreen"

    # App specifics
    "100:class_g = 'dmenu'"
    "100:class_g *= 'Microsoft Teams'"
    "100:name ~= 'Zoom Meeting$'"
    "100:name = 'as_toolbar'" # Zoom screen sharing toolbar
    "100:name *= 'i3lock'"
    "100:window_type = 'utility'" # Firefox/Thunderbird dropdowns
    "100:class_g = 'Alacritty' && focused"
  ];
  shadow = true;
  shadowExclude = [
    "window_type *= 'menu'"

    # App specifics
    "name = 'as_toolbar'" # Zoom screen sharing toolbar
    "name = 'cpt_frame_window'" # Zoom screen sharing frame
    "window_type = 'utility'" # Firefox/Thunderbird dropdowns
  ];
}
