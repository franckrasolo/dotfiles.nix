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
      if client and client.name == "harper_ls" then
        -- stop harper_ls clients without root_dir or with empty settings
        if client.root_dir == nil or next(client.settings) == nil then
          vim.lsp.stop_client(client.id, true)
        end
      end
    end
  })
}
