local lsp_servers = { "tombi" }

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = lsp_servers,
      automatic_enable = { exclude = lsp_servers },
    },
  },

  vim.lsp.enable(lsp_servers),
}
