local wezterm = require 'wezterm'
local config = {}

config.automatically_reload_config = true

config.font = wezterm.font('SF Mono', { weight = 500, italic = false })
config.font_size = 11
config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.colors = {
  background = '{{colors.surface.default.hex}}',
  foreground = '{{colors.on_surface.default.hex}}',
  cursor_border = '{{colors.surface.default.hex}}',
  cursor_bg = '{{colors.on_surface.default.hex}}',
  selection_fg = '{{colors.on_surface.default.hex}}',
  selection_bg = '{{colors.on_surface_variant.default.hex}}',

  scrollbar_thumb = '{{colors.inverse_surface.default.hex}}',
  split = '{{colors.secondary.default.hex}}',

  ansi = {
    '{{colors.surface_variant.default.hex}}',
    '{{colors.inverse_surface.default.hex}}',
    '{{colors.tertiary.default.hex}}', -- Command highlight
    '{{colors.tertiary.default.hex}}',
    '{{colors.inverse_primary.default.hex}}',
    '{{colors.secondary.default.hex}}',
    '{{colors.primary.default.hex}}',
    '{{colors.on_surface.default.hex}}',
  },
  brights = {
      '{{colors.outline.default.hex}}', -- autocomplete or comment
      '{{colors.on_surface_variant.default.hex}}',-- wrong command
      '{{colors.tertiary.default.hex}}',
      '{{colors.tertiary.default.hex}}',
      '{{colors.inverse_primary.default.hex}}',
      '{{colors.secondary.default.hex}}',
      '{{colors.primary.default.hex}}', --Path on starship
      '{{colors.on_surface.default.hex}}',
  },
}

config.window_padding = {
  left = 25,
  right = 25,
  top = 20,
  bottom = 20,
}


-- Event handler for copying text to the clipboard
wezterm.on('fodase', function(window, pane)
  local selection = window:get_selection_text_for_pane(pane)
  wezterm.log_info('Selection copied: ' .. (selection or "No selection"))
end)

config.keys = {
    {
          key = 'C',
          mods = 'CTRL',
          action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection'
        },
    {
        key = 'V',
        mods = "CTRL",
        action = wezterm.action.PasteFrom 'Clipboard'
    },
    {
          key="LeftArrow",
          mods="CTRL|SHIFT",
          action=wezterm.action.SendString "\x17",  -- \x17 is Ctrl+W // Cut previous word
        },
        {
        key = 'RightArrow',
        mods = 'CTRL|SHIFT',
        action=wezterm.action.SendString "\x15", --x15 is ctrl+u // cut next word
        },
        {
            key = "v",
            mods = "CTRL",
            action=wezterm.action.SendString "\x19"
        }
}

config.default_cursor_style = "SteadyBar"

return config
