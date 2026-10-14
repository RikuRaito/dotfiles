local wezterm = require 'wezterm'
local act = wezterm.action

local keys = {
  -- Send exactly the same custom sequences as Ghostty to tmux User0/User1.
  { key = '[', mods = 'SUPER', action = act.SendString '\x1b[5;30012~' },
  { key = ']', mods = 'SUPER', action = act.SendString '\x1b[5;30013~' },

  { key = 't', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },
  { key = 'Tab', mods = 'CTRL|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = '[', mods = 'SUPER|SHIFT', action = act.ActivateTabRelative(-1) },
  { key = ']', mods = 'SUPER|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'w', mods = 'SUPER', action = act.CloseCurrentTab { confirm = true } },
  { key = 'n', mods = 'SUPER', action = act.SpawnWindow },
  { key = 'q', mods = 'SUPER', action = act.QuitApplication },
  { key = 'Enter', mods = 'SUPER', action = act.ToggleFullScreen },
  { key = 'f', mods = 'SUPER|CTRL', action = act.ToggleFullScreen },

  { key = 'c', mods = 'SUPER', action = act.CopyTo 'Clipboard' },
  { key = 'v', mods = 'SUPER', action = act.PasteFrom 'Clipboard' },
  { key = '=', mods = 'SUPER', action = act.IncreaseFontSize },
  { key = '+', mods = 'SUPER|SHIFT', action = act.IncreaseFontSize },
  { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
  { key = '0', mods = 'SUPER', action = act.ResetFontSize },
  { key = ',', mods = 'SUPER|SHIFT', action = act.ReloadConfiguration },

  -- Preserve line-editor navigation without capturing tmux's Ctrl/Alt keys.
  { key = 'LeftArrow', mods = 'SUPER', action = act.SendString '\x01' },
  { key = 'RightArrow', mods = 'SUPER', action = act.SendString '\x05' },
  { key = 'Backspace', mods = 'SUPER', action = act.SendString '\x15' },
  { key = 'LeftArrow', mods = 'ALT', action = act.SendString '\x1bb' },
  { key = 'RightArrow', mods = 'ALT', action = act.SendString '\x1bf' },
}

for number = 1, 8 do
  table.insert(keys, { key = tostring(number), mods = 'SUPER', action = act.ActivateTab(number - 1) })
end
table.insert(keys, { key = '9', mods = 'SUPER', action = act.ActivateTab(-1) })

return { keys = keys, key_tables = {} }
