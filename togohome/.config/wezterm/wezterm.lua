
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
    config.colors = { -- Flexoki Dark
      foreground = '#CECDC3', -- tx
      background = '#100F0F', -- bg
      cursor_bg = '#CECDC3', -- tx
      cursor_fg = '#100F0F', -- bg
      cursor_border = '#CECDC3', -- tx
      selection_fg = '#CECDC3', -- tx
      selection_bg = '#1C1B1A', -- bg-2
      scrollbar_thumb = '#343331', -- ui-2
      split = '#343331', -- ui-2
      ansi = {
        '#100F0F', -- bg
        '#AF3029', -- re
        '#66810B', -- gr
        '#AC8200', -- ye
        '#205EA5', -- bl 
        '#A02F6F', -- ma
        '#24837B', -- cy
        '#86857F', -- tx2
      },
      brights = {
        '#575653', -- tx3
        '#D04D41', -- re
        '#869B39', -- gr
        '#D0A215', -- ye
        '#4285BF', -- bl
        '#CE5C97', -- ma
        '#3CA89F', -- cy
        '#CECDC3', -- tx
      },
      tab_bar = {
        background = '#343331', -- ui-2
        inactive_tab_edge = '#CECDC3', -- tx
        active_tab = {
          bg_color = '#100F0F', -- bg
          fg_color = '#CECDC3', -- tx
        },
        inactive_tab = {
          bg_color = '#343331', -- ui-2
          fg_color = '#CECDC3', -- tx
        },
        inactive_tab_hover = {
          bg_color = '#403E3C', -- ui-3
          fg_color = '#CECDC3', -- tx
        },
        new_tab = {
          bg_color = '#343331', -- ui-2
          fg_color = '#CECDC3', -- tx
        },
        new_tab_hover = {
          bg_color = '#403E3C', -- ui-3
          fg_color = '#CECDC3', -- tx
        },
      }
    }
    config.window_frame = {
      active_titlebar_bg = config.colors.scrollbar_thumb,
      inactive_titlebar_bg = config.colors.scrollbar_thumb,
    }
  else
    config.colors = { -- Flexoki Light 
      foreground = '#100F0F', -- tx
      background = '#FFFCF0', -- bg
      cursor_bg = '#100F0F', -- tx
      cursor_fg = '#FFFCF0', -- bg
      cursor_border = '#100F0F', -- tx
      selection_fg = '#100F0F', -- tx
      selection_bg = '#F2F0E5', -- bg-2
      scrollbar_thumb = '#DAD8CE', -- ui-2
      split = '#DAD8CE', -- ui-2
      ansi = {
        '#FFFCF0', -- bg
        '#D04D41', -- re
        '#869B39', -- gr
        '#D0A215', -- ye
        '#4285BF', -- bl 
        '#CE5C97', -- ma
        '#3CA89F', -- cy
        '#6F6E6A', -- tx2
      },
      brights = {
        '#B7B5AC', -- tx3
        '#AF3029', -- re
        '#66810B', -- gr
        '#AC8200', -- ye
        '#205EA5', -- bl
        '#A02F6F', -- ma
        '#24837B', -- cy
        '#100F0F', -- tx
      },
      tab_bar = {
        background = '#DAD8CE', -- ui-2
        inactive_tab_edge = '#100F0F', -- tx
        active_tab = {
          bg_color = '#FFFCF0', -- bg
          fg_color = '#100F0F', -- tx
        },
        inactive_tab = {
          bg_color = '#DAD8CE', -- ui-2
          fg_color = '#100F0F', -- tx
        },
        inactive_tab_hover = {
          bg_color = '#CECDC3', -- ui-3
          fg_color = '#100F0F', -- tx
        },
        new_tab = {
          bg_color = '#DAD8CE', -- ui-2
          fg_color = '#100F0F', -- tx
        },
        new_tab_hover = {
          bg_color = '#CECDC3', -- ui-3
          fg_color = '#100F0F', -- tx
        },
      }
    }
    config.window_frame = {
      active_titlebar_bg = config.colors.scrollbar_thumb,
      inactive_titlebar_bg = config.colors.scrollbar_thumb,
    }
  end
end

scheme = scheme_for_appearance(get_appearance())
-- config.color_scheme = scheme
-- local colors = wt.color.get_builtin_schemes()[scheme]

config.default_cursor_style = "BlinkingBar"
config.use_fancy_tab_bar = true

config.inactive_pane_hsb = {
  saturation = 1,
  brightness = 1,
}

if wt.target_triple:match("darwin") ~= nil then
  config.native_macos_fullscreen_mode = true
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

  config.hide_tab_bar_if_only_one_tab = false
  config.tab_bar_at_bottom = false

  config.font = wt.font("SF Mono", { weight = "Medium" })
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
      key = 'd',
      mods = 'CMD',
      action = wt.action.SplitHorizontal {
        domain = 'CurrentPaneDomain'
      },
    },
    { -- Horizontal split.
      key = 'D',
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

  config.font = wt.font("Geist Mono", { weight = "Medium" })
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

smsp.apply_to_config(config, {
  direction_keys = { 'h', 'j', 'k', 'l' },
  modifiers = {
    move = 'CTRL',
    resize = 'META',
  },
})

return config

