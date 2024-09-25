return {
  "mizlan/iswap.nvim",
  event = "VeryLazy",
  opts = {
    -- highlight group for the sniping value
    hl_snipe = "ErrorMsg",

    -- highlight group for the visual selection of terms
    hl_selection = "WarningMsg",

    -- highlight group for the greyed background
    hl_grey = "LineNr",

    -- post-operation flashing highlight style
    flash_style = "sequential",

    -- highlight group for flashing highlight afterward
    hl_flash = "TodoBgWARN",

    -- move cursor to the other element in ISwap*With commands
    move_cursor = true,

    -- automatically swap with only two arguments
    autoswap = true,
  },
  keys = {
    { mode = { "n", "v" }, "g.", "", desc = "swaps" },
    { mode = { "n", "v" }, "g..", desc = "Interactive swap", "<cmd>ISwap<cr>" },
    { mode = { "n", "v" }, "g.,", desc = "Swap with another element", "<cmd>ISwapWith<cr>" },
    { mode = { "n", "v" }, "g.;", desc = "Swap arbitrary elements", "<cmd>ISwap<cr>" },
    { mode = { "n", "v" }, "g.'", desc = "Swap with adjacent node", "<cmd>ISwapNodeWith<cr>" },
    { mode = { "n", "v" }, "g.|", desc = "Swap arbitrary adjacent nodes", "<cmd>ISwapNode<cr>" },
  },
}
