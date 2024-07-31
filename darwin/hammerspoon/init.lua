-- append LuaRocks package paths to Hammerspoon/Lua's package paths
local luarocks = "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/luarocks"
package.path  = package.path  .. ";" .. hs.execute(luarocks .. " path --lr-path"):gsub("\n", "")
package.cpath = package.cpath .. ";" .. hs.execute(luarocks .. " path --lr-cpath"):gsub("\n", "")

-- install Hammerspoon's command line tool as /opt/homebrew/bin/hs
hs.ipc.cliInstall()
