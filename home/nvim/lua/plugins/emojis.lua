return {
  "xiyaowong/telescope-emoji.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim" },
  init = function()
		require("telescope").load_extension("emoji")
	end,
  keys =  {
    { "<leader>se", desc = "Insert an emoji", "<cmd>Telescope emoji<cr>" },
  }
}
