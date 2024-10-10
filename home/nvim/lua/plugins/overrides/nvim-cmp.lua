local window_options = {
  border = "rounded",
  scrollbar = false,
  winblend = 0,
  winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
}

return {
  "hrsh7th/nvim-cmp",
  dependencies = { "hrsh7th/cmp-emoji" },
  opts = function(_, opts)
    table.insert(opts.sources, { name = "emoji" })
    opts.window = {
      completion = window_options,
      documentation = window_options,
    }
  end,
}
