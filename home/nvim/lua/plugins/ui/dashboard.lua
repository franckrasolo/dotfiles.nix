return {
  {
    "goolord/alpha-nvim",
    opts = function()
      -- adapted from https://github.com/DaiterGG/neovim-config/blob/b066d0bc66323d70cd423a006faf53e6ba4a08ff/lua/custom/plugins/alpha.lua
      local banner = [[
	                                              
	       ████ ██████           █████      ██
	      ███████████             █████     
	      ████████████████████████████ ███   ███████████
	     █████████  ██████████████████ █████ ██████████████
	    █████████ ██████████ █████████ █████ █████ ████ █████
	  ███████████ ████████ █████████ █████ █████ ████ █████
	 ██████  █████████████████████ ████ █████ █████ ████ ██████
	 ██████   ███████████████████   ██ █████████████████

     © 2020-]] .. os.date("%Y") .. [[ – Franck Rasolo. LazyVim configured with 🧡 in Lua.
]]

      -- highlight groups configuration for each segment
      local header_hl = {}

      table.insert(header_hl, { { "AlphaHeader0_0", 47, 49 } })
      table.insert(header_hl, {
        { "AlphaHeader1_0",  8, 23 },
        { "AlphaHeader1_1", 34, 41 },
        { "AlphaHeader1_2", 41, 51 }
      })
      table.insert(header_hl, {
        { "AlphaHeader2_0",  6, 22 },
        { "AlphaHeader2_1", 33, 46 },
        { "AlphaHeader2_2", 48, 50 },
      })
      table.insert(header_hl, {
        { "AlphaHeader3_0",  6, 20 },
        { "AlphaHeader3_1", 20, 21 },
        { "AlphaHeader3_2", 21, 22 },
        { "AlphaHeader3_2", 22, 36 },
        { "AlphaHeader3_3", 36, 46 },
        { "AlphaHeader3_4", 46, 90 },
      })
      table.insert(header_hl, {
        { "AlphaHeader4_0",  5, 19 },
        { "AlphaHeader4_1", 19, 26 },
        { "AlphaHeader4_2", 26, 30 },
        { "AlphaHeader4_3", 30, 37 },
        { "AlphaHeader4_4", 37, 46 },
        { "AlphaHeader4_5", 46, 90 }
      })
      table.insert(header_hl, {
        { "AlphaHeader5_0",  4, 18 },
        { "AlphaHeader5_1", 18, 38 },
        { "AlphaHeader5_2", 38, 46 },
        { "AlphaHeader5_3", 46, 90 },
      })
      table.insert(header_hl, {
        { "AlphaHeader6_0",  2, 18 },
        { "AlphaHeader6_1", 18, 24 },
        { "AlphaHeader6_2", 24, 28 },
        { "AlphaHeader6_3", 28, 39 },
        { "AlphaHeader6_4", 39, 46 },
        { "AlphaHeader6_5", 46, 90 },
      })
      table.insert(header_hl, {
        { "AlphaHeader7_0",  1, 17 },
        { "AlphaHeader7_1", 17, 39 },
        { "AlphaHeader7_2", 39, 46 },
        { "AlphaHeader7_3", 46, 90 },
      })
      table.insert(header_hl, {
        { "AlphaHeader8_0",  1, 38 },
        { "AlphaHeader8_1", 38, 91 },
      })
      table.insert(header_hl, {})
      table.insert(header_hl, {
        { "AlphaHeaderCopyright", 1, 33 },
        { "AlphaHeaderText", 34, 90 },
      })

      vim.api.nvim_set_hl(0, "AlphaHeader0_0", { fg = "#A6C9AB" })
      vim.api.nvim_set_hl(0, "AlphaHeader1_0", { fg = "#BB7744" })
      vim.api.nvim_set_hl(0, "AlphaHeader1_1", { fg = "#386C3F" })
      vim.api.nvim_set_hl(0, "AlphaHeader1_2", { fg = "#A6C9AB" })
      vim.api.nvim_set_hl(0, "AlphaHeader2_0", { fg = "#BE7D46" })
      vim.api.nvim_set_hl(0, "AlphaHeader2_1", { fg = "#3D7344" })
      vim.api.nvim_set_hl(0, "AlphaHeader2_2", { fg = "#2E4E2A" })
      vim.api.nvim_set_hl(0, "AlphaHeader3_0", { fg = "#C18250" })
      vim.api.nvim_set_hl(0, "AlphaHeader3_1", { fg = "#5C441E" })
      vim.api.nvim_set_hl(0, "AlphaHeader3_2", { fg = "#D6C383" })
      vim.api.nvim_set_hl(0, "AlphaHeader3_3", { fg = "#407B48" })
      vim.api.nvim_set_hl(0, "AlphaHeader3_4", { fg = "#98C09C" })
      vim.api.nvim_set_hl(0, "AlphaHeader4_0", { fg = "#C38950" })
      vim.api.nvim_set_hl(0, "AlphaHeader4_1", { fg = "#E0C785" })
      vim.api.nvim_set_hl(0, "AlphaHeader4_2", { fg = "#5C441E" })
      vim.api.nvim_set_hl(0, "AlphaHeader4_3", { fg = "#E0C785" })
      vim.api.nvim_set_hl(0, "AlphaHeader4_4", { fg = "#44844B" })
      vim.api.nvim_set_hl(0, "AlphaHeader4_5", { fg = "#A0C4A3" })
      vim.api.nvim_set_hl(0, "AlphaHeader5_0", { fg = "#C58F56" })
      vim.api.nvim_set_hl(0, "AlphaHeader5_1", { fg = "#E2CB85" })
      vim.api.nvim_set_hl(0, "AlphaHeader5_2", { fg = "#488C51" })
      vim.api.nvim_set_hl(0, "AlphaHeader5_3", { fg = "#A6C9AB" })
      vim.api.nvim_set_hl(0, "AlphaHeader6_0", { fg = "#C7955B" })
      vim.api.nvim_set_hl(0, "AlphaHeader6_1", { fg = "#E3CF88" })
      vim.api.nvim_set_hl(0, "AlphaHeader6_2", { fg = "#5C441E" })
      vim.api.nvim_set_hl(0, "AlphaHeader6_3", { fg = "#E3CF88" })
      vim.api.nvim_set_hl(0, "AlphaHeader6_4", { fg = "#4D9356" })
      vim.api.nvim_set_hl(0, "AlphaHeader6_5", { fg = "#AECDB3" })
      vim.api.nvim_set_hl(0, "AlphaHeader7_0", { fg = "#C89B62" })
      vim.api.nvim_set_hl(0, "AlphaHeader7_1", { fg = "#E5D38A" })
      vim.api.nvim_set_hl(0, "AlphaHeader7_2", { fg = "#509B59" })
      vim.api.nvim_set_hl(0, "AlphaHeader7_3", { fg = "#B7D1B9" })
      vim.api.nvim_set_hl(0, "AlphaHeader8_0", { fg = "#5C441E" })
      vim.api.nvim_set_hl(0, "AlphaHeader8_1", { fg = "#2E4E2A" })

      vim.api.nvim_set_hl(0, "AlphaHeaderCopyright", { fg = "#E5D38A" })
      vim.api.nvim_set_hl(0, "AlphaHeaderText", { fg = "#B7D1B9" })

      local dashboard = require("alpha.themes.dashboard")

      local header = dashboard.section.header
      local header_val = vim.split(banner, "\n")
      header.opts.hl = require("alpha.utils").charhl_to_bytehl(header_hl, header_val, false)
      header.val = header_val

      local function highlight(section, group, colour)
        section.opts.hl = group
        vim.cmd("highlight " .. group .. " guifg=" .. colour)
      end

      highlight(dashboard.section.buttons, "AlphaButtons", "#E5D38A")
      highlight(dashboard.section.footer,  "AlphaFooter",  "#B7D1B9")
    end
  }
}
