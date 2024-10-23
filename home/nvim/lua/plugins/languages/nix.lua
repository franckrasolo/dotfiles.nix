return {
  "neovim/nvim-lspconfig",
  config = function()
    require("lspconfig").nixd.setup {
      cmd = { "nixd" },
      settings = {
        nixd = {
          nixpkgs = {
            expr = "import <nixpkgs> {}",
          },
        },
      },
    }
  end,
}
