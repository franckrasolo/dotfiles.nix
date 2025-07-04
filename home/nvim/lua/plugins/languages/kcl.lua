return {
  "kcl-lang/kcl.nvim",
  dependencies = { "neovim/nvim-lspconfig" },
  event = "VeryLazy",
  ft = "kcl",
  config = function()
    require("lspconfig").kcl.setup {}
  end,
}
