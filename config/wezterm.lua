local wt = require 'wezterm'
local config = wt.config_builder()

local smsp = wt.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

function get_appearance()
  if wt.gui then
    return wt.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return "Tomorrow Night (Gogh)"  -- Tomorrow Night, Dark Mode
  else
    return "Tomorrow (Gogh)"        -- Tomorrow, Light Mode
  end
end

scheme = scheme_for_appearance(get_appearance())
config.color_scheme = scheme
local colors = wt.color.get_builtin_schemes()[scheme]

config.default_cursor_style = "BlinkingBar"
config.use_fancy_tab_bar = true

config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1,
}

config.window_frame = {
  active_titlebar_bg = colors.ansi[1],
  inactive_titlebar_bg = colors.ansi[1],
}

if wt.target_triple:match("darwin") ~= nil then
  config.native_macos_fullscreen_mode = true
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

  config.hide_tab_bar_if_only_one_tab = false
  config.tab_bar_at_bottom = false

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

  -- TODO: make these binds also work on linux
  -- derivative of https://github.com/diego-vicente/dotfiles/blob/c52583ab3c125500d88e43530fc6984b01908501/wezterm/wezterm.lua
  config.keys = {
    { -- Show tab navigator.
      key = 'p',
      mods = 'CMD',
      action = wt.action.ShowTabNavigator
    },
    { -- Show launcher.
      key = 'P',
      mods = 'CMD|SHIFT',
      action = wt.action.ShowLauncher
    },
    { -- Rename current tab.
      key = 'E',
      mods = 'CMD|SHIFT',
      action = wt.action.PromptInputLine {
        description = 'Enter new name for tab',
        action = wt.action_callback(
          function(window, _, line)
            if line then
              window:active_tab():set_title(line)
            end
          end
        ),
      },
    },

    { -- Vertical split.
      key = '\\',
      mods = 'CMD|SHIFT',
      action = wt.action.SplitHorizontal {
        domain = 'CurrentPaneDomain'
      },
    },
    { -- Horizontal split.
      key = '-',
      mods = 'CMD|SHIFT',
      action = wt.action.SplitVertical {
        domain = 'CurrentPaneDomain'
      },
    },

    {
      key = "w",
      mods = "CMD",
      action = wt.action.CloseCurrentPane { confirm = true }
    },
    {
      key = "w",
      mods = "CMD|SHIFT",
      action = wt.action.CloseCurrentTab { confirm = true }
    }
  }
else
  config.window_decorations = "RESIZE"

  config.hide_tab_bar_if_only_one_tab = true
  config.tab_bar_at_bottom = true

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
