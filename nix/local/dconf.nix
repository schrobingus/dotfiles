# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;
{
  dconf.settings = {
    # Sets the wallpaper.
    "org/gnome/desktop/background" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/brent/.local/share/backgrounds/PaperlikeXCanoopsyRecolor.png";
      picture-uri-dark = "file:///home/brent/.local/share/backgrounds/PaperlikeXCanoopsyRecolor.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    # Swaps the caps and control for ergonomics.
    "org/gnome/desktop/input-sources" = {
      sources = [ (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "ctrl:swapcaps" ];
    };

    # Set fonts, icons, themes, clock settings, and more.
    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = true;
      color-scheme = "default";
      cursor-theme = "phinger-cursors";
      document-font-name = "IBM Plex Sans Medium 11";
      enable-animations = true;
      enable-hot-corners = false;
      font-antialiasing = "grayscale";
      font-hinting = "slight";
      font-name = "IBM Plex Sans Medium 11";
      gtk-theme = "adw-gtk3";
      icon-theme = "Papirus-Dark";
      locate-pointer = false;
      monospace-font-name = "IBM Plex Mono Medium 11";
      show-battery-percentage = false;
    };

    # Enable two finger scrolling and disable (un)natural scrolling.
    "org/gnome/desktop/peripherals/touchpad" = {
      natural-scroll = false;
      two-finger-scrolling-enabled = true;
    };

    # Enable the lock wall.
    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "file:///home/brent/.local/share/backgrounds/PaperlikeXCanoopsyRecolor.png";
      primary-color = "#000000000000";
      secondary-color = "#000000000000";
    };

    # Set Mutter settings. I don't need minimizing since I rely on workspaces.
    "org/gnome/desktop/wm/preferences" = {
      action-double-click-titlebar = "toggle-maximize";
      action-middle-click-titlebar = "none";
      auto-raise = false;
      button-layout = "appmenu:close";
      focus-mode = "sloppy";
      titlebar-font = "IBM Plex Sans Medium 11";
      workspace-names = [];
    };

    # Enable the non-capped dynamic workspaces.
    "org/gnome/mutter" = {
      dynamic-workspaces = true;
    };

    # Enable night light for better viewing late.
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-temperature = mkUint32 4243;
    };

    # Configure extensions.
    "org/gnome/shell" = {
      disable-user-extensions = false;
      #disabled-extensions = [ "fildemGMenu@gonza.com" "workspace-indicator@gnome-shell-extensions.gcampax.github.com" "horizontal-workspace-indicator@tty2.io" ];
      #enabled-extensions = [ "improved-workspace-indicator@michaelaquilina.github.io" "arcmenu@arcmenu.com" "Applications_Menu@rmy.pobox.com" "favourites-in-appgrid@harshadgavali.gitlab.org" "pop-shell@system76.com" "vertical-overview@RensAlthuis.github.com" "dash-to-dock-cosmic-@halfmexicanhalfamazing@gmail.com" "workspaces-bar@fthx" "openweather-extension@jenslody.de" "dash-to-panel@jderose9.github.com" ];
    };

    # Configure Dash to Dock.
    "org/gnome/shell/extensions/dash-to-dock" = {
      background-color = "rgb(15,15,15)";
      background-opacity = 0.8;
      custom-background-color = true;
      custom-theme-shrink = true;
      dash-max-icon-size = 48;
      disable-overview-on-startup = true;
      dock-fixed = false;
      dock-position = "LEFT";
      extend-height = false;
      height-fraction = 0.9;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "eDP-1";
      preview-size-scale = 0.0;
      running-indicator-style = "DASHES";
      show-apps-at-top = false;
      transparency-mode = "FIXED";
    };

    # Configure Dash to Panel (it looks nearly identical to vanilla, but with improvements).
    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover-animation-extent = "{'RIPPLE': 4, 'PLANK': 4, 'SIMPLE': 1}";
      appicon-margin = 8;
      appicon-padding = 4;
      available-monitors = [ 0 ];
      dot-position = "LEFT";
      hotkeys-overlay-combo = "TEMPORARILY";
      leftbox-padding = 0;
      leftbox-size = 0;
      panel-anchors = ''
        {"0":"MIDDLE"}
      '';
      panel-element-positions = ''
        {"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"stackedTL"},{"element":"taskbar","visible":false,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"centerMonitor"},{"element":"dateMenu","visible":true,"position":"centerMonitor"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}
      '';
      panel-lengths = ''
        {"0":100}
      '';
      panel-positions = ''
        {"0":"TOP"}
      '';
      panel-sizes = ''
        {"0":32}
      '';
      status-icon-padding = -1;
      stockgs-keep-dash = true;
      trans-bg-color = "#0f0f0f";
      trans-use-custom-bg = true;
      tray-padding = -1;
      tray-size = 0;
      window-preview-title-position = "TOP";
    };

    # Configure the workspace bar.
    "org/gnome/shell/extensions/improved-workspace-indicator" = {
      change-on-click = true;
      panel-position = "left";
    };

    # Enable Openweather, and configure for Ashland, Oregon.
    "org/gnome/shell/extensions/openweather" = {
      actual-city = 0;
      center-forecast = true;
      city = "42.1972487,-122.7153995>Ashland>0";
      days-forecast = 1;
      decimal-places = 1;
      disable-forecast = true;
      geolocation-provider = "openstreetmaps";
      position-in-panel = "center";
      pressure-unit = "inHg";
      show-comment-in-forecast = true;
      show-text-in-panel = true;
      translate-condition = true;
      unit = "fahrenheit";
      use-default-owm-key = true;
      use-system-icons = true;
      weather-provider = "openweathermap";
      wind-speed-unit = "mph";
    };

    # Configure Pop shell.
    "org/gnome/shell/extensions/pop-shell" = {
      tile-by-default = false;
    };

    # Configure the Vertical Activities (similar to GNOME 3).
    "org/gnome/shell/extensions/vertical-overview" = {
      override-dash = false;
    };

    # Disable the extensions popup for Tweak Tool.
    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    # Configure the file chooser.
    "org/gtk/gtk4/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 167;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
      window-size = mkTuple [ 640 480 ];
    };
  };
}
