return {
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        -- move visual selection in visual mode
        left = "<S-Left>",
        right = "<S-Right>",
        down = "<S-Down>",
        up = "<S-Up>",

        -- move current line in normal mode
        line_left = "<S-Left>",
        line_right = "<S-Right>",
        line_down = "<S-Down>",
        line_up = "<S-Up>",
      },
    },
  },
}
