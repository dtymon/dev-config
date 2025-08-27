local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.front_end = 'WebGpu'
config.font_size = 15
config.font = wezterm.font_with_fallback({
  {
     family = "M+CodeLat60 Nerd Font Mono",
     weight = "Medium"
  },
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
config.window_background_opacity = 0.92
config.skip_close_confirmation_for_processes_named = {}

-- config.window_decorations = 'RESIZE|MACOS_FORCE_ENABLE_SHADOW|MACOS_USE_BACKGROUND_COLOR_AS_TITLEBAR_COLOR'
-- config.window_decorations = 'RESIZE|MACOS_FORCE_ENABLE_SHADOW|INTEGRATED_BUTTONS|INTEGRATED_BUTTONS'
config.window_decorations = 'RESIZE|MACOS_FORCE_ENABLE_SHADOW'

local act = wezterm.action

local function activatePane(direction)
   return {
      key = direction..'Arrow',
      mods = 'SHIFT',
      action = act.ActivatePaneDirection(direction),
   }
end

local function adjustPaneSize(direction)
   return {
      key = direction..'Arrow',
      mods = 'CTRL|SHIFT',
      action = act.AdjustPaneSize({ direction, 1 }),
   }
end

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
  activatePane('Left'),
  activatePane('Right'),
  activatePane('Up'),
  activatePane('Down'),
  adjustPaneSize('Left'),
  adjustPaneSize('Right'),
  adjustPaneSize('Up'),
  adjustPaneSize('Down'),
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
  -- Press Ctrl-Shift S to enter mode to swap pane contents
  {
    key = 'S',
    mods = 'CTRL|SHIFT',
    action = act.PaneSelect({ mode = 'SwapWithActive' }),
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
    -- Instead, use a different modifier combination to start window drags
    {
       event = { Drag = { streak = 1, button = "Left" } },
       mods = "CTRL|SHIFT",
       action = act.StartWindowDrag,
    },
}

-- wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
--               return pane.current_working_dir.path
-- end)

return config
