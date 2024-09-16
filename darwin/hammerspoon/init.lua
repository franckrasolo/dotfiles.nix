-- append LuaRocks package paths to Hammerspoon/Lua's package paths
local luarocks = "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/luarocks"
package.path  = package.path  .. ";" .. hs.execute(luarocks .. " path --lr-path"):gsub("\n", "")
package.cpath = package.cpath .. ";" .. hs.execute(luarocks .. " path --lr-cpath"):gsub("\n", "")

-- install Hammerspoon's command line tool as /opt/homebrew/bin/hs
hs.ipc.cliInstall()

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
