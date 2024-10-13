return {
  "shellRaining/hlchunk.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    chunk = {
      enable = true,
      notify = false,
      use_treesitter = true,
      chars = {
        horizontal_line = "─",
        vertical_line = "│",
        left_top = "╭",
        left_bottom = "╰",
        left_arrow = "─",
        right_arrow = "▶",
      },
      style = {
        "#c6a0f6",
        "#ed8796", -- for chunks with errors
      },
    },
    line_num = {
      enable = true,
      use_treesitter = true,
      style = "#c6a0f6",
    },
    indent = {
      enable = true,
      use_treesitter = false,
      chars = {
        "┆",
        "│",
        "┊",
        "┆",
      },
      style = "#2A2A37",
    },
    blank = { enable = false },
  }
}
