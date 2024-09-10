local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local theme = "Jellybeans"

config.color_scheme = theme
local theme_colors = wezterm.color.get_builtin_schemes()[theme]

config.default_cursor_style = "BlinkingBar"

config.hide_tab_bar_if_only_one_tab = false
config.native_macos_fullscreen_mode = true;
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.font = wezterm.font 'SF Mono'
config.font_size = 13

-- TODO: add top padding when no tab bar, and remove when tab bar enabled
config.window_padding = {
  left = 32,
  right = 32,
  top = 32,
  bottom = 32,
}

config.window_frame = {
  font = wezterm.font { family = 'SF Compact' },
  font_size = 13,
  active_titlebar_bg = theme_colors.ansi[1],
  inactive_titlebar_bg = theme_colors.ansi[1],
}

config.colors = {
  tab_bar = {
    background = theme_colors.foreground,
    inactive_tab_edge = theme_colors.ansi[1],
    active_tab = {
      bg_color = theme_colors.background,
      fg_color = theme_colors.foreground,
    },
    inactive_tab = {
      bg_color = theme_colors.foreground,
      fg_color = theme_colors.background,
    },
    inactive_tab_hover = {
      bg_color = theme_colors.ansi[5],
      fg_color = theme_colors.background,
    },
    new_tab = {
      bg_color = theme_colors.ansi[1],
      fg_color = theme_colors.background,
    },
    new_tab_hover = {
      bg_color = theme_colors.ansi[5],
      fg_color = theme_colors.background,
    },
  },
}

return config
