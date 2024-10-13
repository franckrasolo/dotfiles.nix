return {
  "xiyaowong/telescope-emoji.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("telescope").load_extension("emoji")
  end,
  keys = {
    { "<leader>se", desc = "Insert an emoji", "<cmd>Telescope emoji<cr>" },
  }
}
