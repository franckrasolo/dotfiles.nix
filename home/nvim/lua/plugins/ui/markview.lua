return {
  "OXY2DEV/markview.nvim",
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function(_, opts)
    local markview = require("markview")
    markview.setup(opts)

    LazyVim.toggle.map("<leader>um", {
      name = "Markdown Preview",
      get = function()
        return markview.state.enable
      end,
      set = function(enabled)
        if enabled then
          markview.commands.enableAll()
        else
          markview.commands.disableAll()
        end
      end,
    })
  end,
}
