-- Gala filetype + LSP
vim.filetype.add {
  extension = {
    gala = "gala",
  },
}

vim.lsp.enable("gala")
