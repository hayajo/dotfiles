local wezterm = require 'wezterm'
local config  = wezterm.config_builder()
local act     = wezterm.action

config.window_background_opacity    = 0.88
-- config.macos_window_background_blur = 20

-- config.font                      = wezterm.font("Monaco")
config.font                      = wezterm.font("JetBrains Mono")
config.font_size                 = 14.0
config.command_palette_font_size = 18.0

config.harfbuzz_features = {
    "calt=0",
    "liga=0",
    "dlig=0",
}

config.initial_rows      = 50
config.initial_cols      = 100
config.enable_scroll_bar = true

config.inactive_pane_hsb = {
  saturation = 0.5,
  brightness = 0.5,
}

-- config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.audible_bell = "Disabled"
config.visual_bell  = {
  fade_in_function     = 'EaseIn',
  fade_in_duration_ms  = 150,
  fade_out_function    = 'EaseOut',
  fade_out_duration_ms = 150,
}
config.colors = {
  visual_bell = '#202020',
}

config.color_scheme = 'tokyonight_night'

config.use_ime                            = true
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

-- config.disable_default_key_bindings = true
config.leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000  }
config.keys   = {
  { key = 'v',         mods = 'LEADER',      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 's',         mods = 'LEADER',      action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'k',         mods = 'LEADER',      action = act.ActivatePaneDirection 'Up' },
  { key = 'j',         mods = 'LEADER',      action = act.ActivatePaneDirection 'Down' },
  { key = 'l',         mods = 'LEADER',      action = act.ActivatePaneDirection 'Right' },
  { key = 'h',         mods = 'LEADER',      action = act.ActivatePaneDirection 'Left' },
  { key = 'c',         mods = 'LEADER',      action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'p',         mods = 'LEADER',      action = act.ActivateTabRelative(-1) },
  { key = 'n',         mods = 'LEADER',      action = act.ActivateTabRelative(1) },
  { key = "[",         mods = "LEADER",      action = act.ActivateCopyMode },
  { key = 'o',         mods = 'LEADER',      action = act.TogglePaneZoomState },
  { key = 'f',         mods = 'LEADER',      action = act.QuickSelect },
  { key = "p",         mods = "SHIFT|SUPER", action = act.ActivateCommandPalette },
  { key = 'UpArrow',   mods = 'SHIFT',       action = act.ScrollToPrompt(-1) },
  { key = 'DownArrow', mods = 'SHIFT',       action = act.ScrollToPrompt(1) },
}

config.key_tables = {
  search_mode = {
    { key = 'Enter',     mods = 'NONE',  action = act.CopyMode 'PriorMatch' },
    {
      key = 'Escape',
      mods = 'NONE',
      action = act.Multiple {
          act.CopyMode 'ClearPattern',
          act.CopyMode 'Close',
      }
    },
    {
      key = 'c',
      mods = 'CTRL',
      action = act.Multiple {
          act.CopyMode 'ClearPattern',
          act.CopyMode 'Close',
      }
    },
    { key = 'n',         mods = 'CTRL',  action = act.CopyMode 'NextMatch' },
    { key = 'p',         mods = 'CTRL',  action = act.CopyMode 'PriorMatch' },
    { key = 'r',         mods = 'CTRL',  action = act.CopyMode 'CycleMatchType' },
    { key = 'f',         mods = 'SUPER', action = act.CopyMode 'CycleMatchType' },
    { key = 'u',         mods = 'CTRL',  action = act.CopyMode 'ClearPattern' },
    { key = 'PageUp',    mods = 'NONE',  action = act.CopyMode 'PriorMatchPage' },
    { key = 'PageDown',  mods = 'NONE',  action = act.CopyMode 'NextMatchPage' },
    { key = 'UpArrow',   mods = 'NONE',  action = act.CopyMode 'PriorMatch' },
    { key = 'DownArrow', mods = 'NONE',  action = act.CopyMode 'NextMatch' },
  }
}

return config
