local lsp_servers = { "harper_ls" }

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
      -- stop harper_ls clients with empty settings
      if client and client.name == "harper_ls" and next(client.settings) == nil then
        vim.lsp.stop_client(client.id, true)
      end
    end
  })
}
