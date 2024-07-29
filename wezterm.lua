local wezterm = require 'wezterm'
local config = wezterm.config_builder()

local theme = "Jellybeans"

config.color_scheme = theme
local theme_colors = wezterm.color.get_builtin_schemes()[theme]

config.default_cursor_style = "BlinkingBar"

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.window_decorations = "RESIZE"

config.font = wezterm.font 'Cozette'
config.font_size = 13

config.window_padding = {
  left = 16,
  right = 16,
  top = 16,
  bottom = 16,
}

config.colors = {
  tab_bar = {
    background = theme_colors.ansi[1],
    active_tab = {
      bg_color = theme_colors.background,
      fg_color = theme_colors.foreground,
    },
    inactive_tab = {
      bg_color = theme_colors.ansi[1],
      fg_color = theme_colors.foreground,
    },
    inactive_tab_hover = {
      bg_color = theme_colors.ansi[1],
      fg_color = theme_colors.foreground,
      italic = true,
    },
    new_tab = {
      bg_color = theme_colors.ansi[1],
      fg_color = theme_colors.foreground,
    },
    new_tab_hover = {
      bg_color = theme_colors.ansi[1],
      fg_color = theme_colors.foreground,
      italic = true,
    },
  },
}

return config
