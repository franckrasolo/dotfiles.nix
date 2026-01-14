require("luarocks")
require("moonscript")

-- install Hammerspoon's command line tool as /opt/homebrew/bin/hs
hs.ipc.cliInstall()

--[[
hs.loadSpoon("SpoonInstall")
--spoon.SpoonInstall:andUse("EmmyLua")

--local WindowManagement = require("WindowManagement")
--require("AdvancedWindowManagement")

--[[
spoon.SpoonInstall.repos.PaperWM = {
   url = "https://github.com/mogenson/PaperWM.spoon",
   desc = "PaperWM.spoon repository",
   branch = "release",
}

spoon.SpoonInstall.repos.ShiftIt = {
   url = "https://github.com/peterklijn/hammerspoon-shiftit",
   desc = "ShiftIt spoon repository",
   branch = "master",
}

spoon.SpoonInstall:andUse("ShiftIt", { repo = "ShiftIt" })
]]

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0 -- disable animations to prevent choppiness when cycling through sizes

--hs.grid.show()
hs.grid.ui.showExtraKeys = false
local margins = hs.geometry.point(0, 26)
--hs.grid.setMargins(margins).setGrid(hs.geometry.size(10, 4)).toggleShow()
--hs.grid.setMargins(margins).setGrid(hs.geometry.size(24, 24)).toggleShow()

spoon.MiroWindowsManager.sizes = { 2, 3 / 2, 4 / 3, 24 / 23 }
--spoon.MiroWindowsManager.sizes = { 0.5, 0.667, 0.75, 0.95833 }
--spoon.MiroWindowsManager.sizes = { 12, 16, 18, 23 }
spoon.MiroWindowsManager.fullScreenSizes = { 2, 3 / 2, 4 / 3, 24 / 23 }
spoon.MiroWindowsManager._logger.setLogLevel('warning')

--[[
local leader = { "ctrl", "cmd" }
spoon.MiroWindowsManager:bindHotkeys({
  left       = { leader, "h" },
  right      = { leader, "l" },
  up         = { leader, "k" },
  down       = { leader, "j" },
  --topLeft     = { leader, "u" },
  --topright    = { leader, "p" },
  --bottomLeft  = { leader, "n" },
  --bottomRight = { leader, "." },
  center     = { leader, "c" },
  fullscreen = { leader, "f" },
  move       = { { "shift", "cmd" }, "space" },
  resize     = { { "shift", "ctrl" }, "space" },
  --fullScreen  = { leader, "f" },
  nextscreen = { leader, "n" },
  --nextScreen  = { leader, "n" },
})
]]

-- automatically reload changes to Hammerspoon's configuration
HammerspoonHome = os.getenv("HOME") .. "/.xdg/config/hammerspoon/"

local function reloadConfig(files)
  doReload = false
  for _, file in pairs(files) do
    if file:sub(-4) == ".lua" then
      doReload = true
    end
  end
  if doReload then
    hs.reload()
  end
end

fileWatcher = hs.pathwatcher.new(HammerspoonHome, reloadConfig):start()

-- automatically close the Hammerspoon Console when it loses focus
-- source: https://gist.github.com/asmagill/251f8ea70b61a177a205
local function closeConsole(name, event, _)
  if name and name:match("Hammerspoon") and event == hs.application.watcher.deactivated then
    local console = hs.appfinder.windowFromWindowTitle("Hammerspoon Console")
    if console then console:close() end
  end
end

consoleWatcher = hs.application.watcher.new(closeConsole):start()
