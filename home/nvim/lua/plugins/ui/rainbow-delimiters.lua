return {
  "HiPhish/rainbow-delimiters.nvim",
  event = "VeryLazy",
  config = function()
    local rainbow_delimiters = require("rainbow-delimiters")
    vim.g.rainbow_delimiters = {
      strategy = {
        [""] = rainbow_delimiters.strategy["global"],
        vim  = rainbow_delimiters.strategy["local"],
      },
      query = {
        [""] = "rainbow-delimiters",
        lua  = "rainbow-blocks",
      },
      priority = {
        [""] = 110,
        lua  = 210,
      },
      highlight = {
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterRed",
        "RainbowDelimiterBlue",
        "RainbowDelimiterViolet",
        "RainbowDelimiterYellow",
        "RainbowDelimiterCyan",
      },
    }
  end,
  keys = {
    { "<leader>ur", function() require("rainbow-delimiters").toggle(0) end, desc = "Toggle Rainbow Delimiters" },
  },
}
