-- make LuaRocks packages available to a Lua runtime
local luarocks = "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin/luarocks"

function execute(prog)
  return io.popen(prog):read("*a")
end

package.path  = package.path  .. ";" .. execute(luarocks .. " path --lr-path"):gsub("\n", "")
package.cpath = package.cpath .. ";" .. execute(luarocks .. " path --lr-cpath"):gsub("\n", "")
