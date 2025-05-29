local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font_size = 17.5
config.font = wezterm.font_with_fallback({
  {family="M+CodeLat60 Nerd Font Mono", weight="Medium"}
})

config.colors = {
  foreground = '#e5e5f0',
  background = '#091c31',
  cursor_bg = '#fa0000',
  cursor_fg = '#e5e5f0',
  cursor_border = '#fa0000',
  selection_bg = '#fae060',
  selection_fg = '#053570',
}

config.inactive_pane_hsb = {
  saturation = 1.0,
  brightness = 0.8,
}

config.audible_bell = 'Disabled'
config.cursor_blink_rate = 0
config.enable_tab_bar = false
config.scrollback_lines = 5000
config.selection_word_boundary = ' \t\n{[}]()"\':'
config.swallow_mouse_click_on_window_focus = false
config.term = 'xterm-256color'
config.window_close_confirmation = 'AlwaysPrompt'
config.skip_close_confirmation_for_processes_named = {}
-- config.window_decorations = 'RESIZE'

local act = wezterm.action
config.keys = {
  {
    key = 'Insert',
    mods = 'SHIFT',
    action = act.PasteFrom('Clipboard'),
  },
  {
    key = 'phys:Help',
    mods = 'SHIFT',
    action = act.PasteFrom('Clipboard'),
  },
--   {
--     key = 'raw:114',
--     mods = 'SHIFT',
--     action = act.PasteFrom('Clipboard'),
--   },
  {
    key = 'F4',
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'F5',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'LeftArrow',
    mods = 'SHIFT',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'SHIFT',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'SHIFT',
    action = act.ActivatePaneDirection 'Down',
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Left', 1 },
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Right', 1 },
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Up', 1 },
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Down', 1 },
  },
  {
    key = 'PageUp',
    mods = 'SHIFT',
    action = act.ScrollByPage(-1),
  },
  {
    key = 'PageDown',
    mods = 'SHIFT',
    action = act.ScrollByPage(1),
  },
  {
    key = 'Z',
    mods = 'CTRL|SHIFT',
    action = act.TogglePaneZoomState,
  },
}

-- config.debug_key_events = true

config.mouse_bindings = {
    -- Disable the default click behavior
    {
      event = { Up = { streak = 1, button = "Left"} },
      mods = "NONE",
      action = act.CompleteSelection('ClipboardAndPrimarySelection'),
    },
    -- Cmd-click will open the link under the mouse cursor
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "SUPER",
        action = act.OpenLinkAtMouseCursor,
    },
    -- Disable the Cmd-click down event to stop programs from seeing it when a
    -- URL is clicked
    {
       event = { Down = { streak = 1, button = "Left" } },
       mods = "SUPER",
       action = act.Nop,
    },
    -- Disable this annoying binding that starts window moves when trying to
    -- click on a link.
    {
       event = { Drag = { streak = 1, button = "Left" } },
       mods = "SUPER",
       action = act.Nop,
    },
}

return config
