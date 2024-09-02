return function(config)
  local wezterm = require("wezterm")
  local action = wezterm.action
  local mod = "ALT|SHIFT"

  local function zellij(args)
    os.execute("/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/zellij " .. args)
  end

  config.keys = {
    {
      mods = "CMD|SHIFT",
      key = "K",
      action = wezterm.action_callback(function(window, pane)
        if pane:get_foreground_process_info()["name"] == "zellij" then
          zellij("action clear")
          zellij("action write 12") -- 12 -> ^L
        else
          window:perform_action(
              action.Multiple {
                action.ClearScrollback "ScrollbackAndViewport",
                action.SendKey { mods = "CTRL", key = "L" },
              },
              pane
          )
        end
      end)
    },
    { mods = mod, key = "|", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { mods = mod, key = "\"", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { mods = mod, key = "LeftArrow", action = action.ActivatePaneDirection "Left" },
    { mods = mod, key = "RightArrow", action = action.ActivatePaneDirection "Right" },
    { mods = mod, key = "UpArrow", action = action.ActivatePaneDirection "Up" },
    { mods = mod, key = "DownArrow", action = action.ActivatePaneDirection "Down" },
    { mods = mod, key = "Enter", action = action.TogglePaneZoomState },
  }

  config.send_composed_key_when_left_alt_is_pressed = true
end
