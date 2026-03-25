return {
  {
    "apple/pkl-neovim",
    ft = "pkl",
    lazy = true,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter",
        build = function(_) vim.cmd("TSUpdate") end,
      },
      "L3MON4D3/LuaSnip",
    },
    build = function()
      require("pkl-neovim").init()

      -- set up syntax highlighting
      vim.cmd("TSInstall pkl")
    end,
    config = function()
      require("luasnip.loaders.from_snipmate").lazy_load()

      vim.g.pkl_neovim = {
        start_command = { "pkl-lsp" },
      }
    end,
  },
}
