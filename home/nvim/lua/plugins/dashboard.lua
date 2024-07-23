return {
  {
    "goolord/alpha-nvim",
    opts = function()
      -- adapted from https://github.com/MaximilianLloyd/ascii.nvim/blob/c1a315e811fa7c133f8f4827e63015a480d8a81b/lua/ascii/text/neovim.lua#L224-L234
      local banner = [[
	                                              
	       ████ ██████           █████      ██
	      ███████████             █████ 
	      █████████ ███████████████████ ███   ███████████
	     █████████  ███    █████████████ █████ ██████████████
	    █████████ ██████████ █████████ █████ █████ ████ █████
	  ███████████ ███    ███ █████████ █████ █████ ████ █████
	 ██████  █████████████████████ ████ █████ █████ ████ ██████

     © 2020-]] .. os.date("%Y") .. [[ – Franck Rasolo. LazyVim configured with 🧡 in Lua.
]]

      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = vim.split(banner, "\n")

      local function highlight(section, group, colour)
        section.opts.hl = group
        vim.cmd ("highlight " .. group .. " guifg=" .. colour)
      end

      highlight(dashboard.section.header,  "AlphaHeader",  "#34BF91")
      highlight(dashboard.section.buttons, "AlphaButtons", "#FFE9D4")
      highlight(dashboard.section.footer,  "AlphaFooter",  "#A9FFCA")
    end
  }
}
