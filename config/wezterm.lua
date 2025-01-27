local wt = require 'wezterm'
local config = wt.config_builder()

-- TODO: rebind split keybindings that aren't addressed by smart-splits
-- TODO: rebind most everything that is inconvenient to hit

local smsp = wt.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

-- TODO: the tt base16 scheme is different. make this work via pr or a custom function
-- local colors, metadata = wt.color.load_base16_scheme("/Users/brent/.config/tt-schemes/base16/tomorrow-night.yaml")
-- config.colors = colors

-- TODO: change to base16
local theme = "Tomorrow Night"
-- local theme = "Solarized (dark) (terminal.sexy)"
config.color_scheme = theme
local colors = wt.color.get_builtin_schemes()[theme]

config.default_cursor_style = "BlinkingBar"
  config.use_fancy_tab_bar = true

if wt.target_triple:match("darwin") ~= nil then
  config.native_macos_fullscreen_mode = true
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

  config.hide_tab_bar_if_only_one_tab = false
  config.tab_bar_at_bottom = false
else
  config.window_decorations = "RESIZE"

  config.hide_tab_bar_if_only_one_tab = true
  config.tab_bar_at_bottom = true
end

config.font = wt.font 'SF Mono'

config.window_frame = {
  active_titlebar_bg = colors.ansi[1],
  inactive_titlebar_bg = colors.ansi[1],
}

if wt.target_triple:match("darwin") ~= nil then
  config.font = wt.font 'SF Mono'
  config.font_size = 13
  config.window_frame.font = wt.font { family = "SF Compact" }
  config.window_frame.font_size = 13
  config.window_padding = {
    left = 32,
    right = 32,
    top = 32,
    bottom = 32,
  }
else
  config.font = wt.font 'Geist Mono'
  config.font_size = 9
  config.window_frame.font = wt.font { family = "Geist" }
  config.window_frame.font_size = 9
  config.window_padding = {
    left = 16,
    right = 16,
    top = 16,
    bottom = 16,
  }
end

config.colors = {
  tab_bar = {
    background = colors.foreground,
    inactive_tab_edge = colors.ansi[1],
    active_tab = {
      bg_color = colors.background,
      fg_color = colors.foreground,
    },
    inactive_tab = {
      bg_color = colors.foreground,
      fg_color = colors.background,
    },
    inactive_tab_hover = {
      bg_color = colors.ansi[5],
      fg_color = colors.background,
    },
    new_tab = {
      bg_color = colors.ansi[1],
      fg_color = colors.background,
    },
    new_tab_hover = {
      bg_color = colors.ansi[5],
      fg_color = colors.background,
    },
  },
}

smsp.apply_to_config(config, {
  direction_keys = { 'h', 'j', 'k', 'l' },
  modifiers = {
    move = 'CTRL',
    resize = 'META',
  },
})

return config
