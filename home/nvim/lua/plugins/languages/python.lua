local lsp_servers = { "basedpyright", "ruff" }

return {
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = lsp_servers,
      automatic_enable = { exclude = lsp_servers },
    },
  },

  vim.lsp.enable(lsp_servers),

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      -- stop ruff clients with a "utf-8" offset encoding
      if client and client.name == "ruff" and client.offset_encoding == "utf-8" then
        vim.lsp.stop_client(client.id, true)
      end
    end
  })
}
