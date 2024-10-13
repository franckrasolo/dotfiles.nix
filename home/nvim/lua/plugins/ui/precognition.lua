return {
  "tris203/precognition.nvim",
  opts = {
    startVisible = false,
    highlightColor = { fg = "#FFEBD2", bold = true, italic = true },
  },
  keys = {
    { "<leader>u<tab>", desc = "Toggle Precognition", function() require("precognition").toggle() end }
  }
}
