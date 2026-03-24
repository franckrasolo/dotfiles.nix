vim.filetype.add {
  extension = {
    ghostty = "ghostty",
  },
  pattern = {
    [".*/cmux/config"] = "ghostty",
    [".*/ghostty/config"] = "ghostty",
  },
}

vim.lsp.enable("ghostty")
