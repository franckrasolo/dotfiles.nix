return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      hover = {
        -- do not show a message if hover is not available
        silent = true,
      },
    },
    presets = {
      -- add a border to hover docs and signature help
      lsp_doc_border = true,
    },
  },
}
