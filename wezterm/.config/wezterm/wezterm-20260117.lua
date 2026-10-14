local wezterm = require 'wezterm'
local config = dofile(wezterm.config_dir .. '/wezterm.lua')

-- The January build uses the old macOS transparency implementation.
-- Remove the full-window background layer to keep the area around tabs clear.
config.window_background_gradient = nil
config.check_for_updates = false

return config
