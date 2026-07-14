vim.filetype.add {
  extension = {
    ghostty = "ghostty",
  },
  pattern = {
    [".*/ghostty/config"] = "ghostty",
  },
}

vim.lsp.enable("ghostty")
