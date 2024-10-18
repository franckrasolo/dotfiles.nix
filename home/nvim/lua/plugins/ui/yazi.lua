return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  opts = {
    floating_window_scaling_factor = {
      width = 0.96,
      height = 0.8,
    },
    keymaps = {
      show_help = "g?",
      open_file_in_tab = false,
      grep_in_directory = "<c-a-/>",
      replace_in_directory = "<c-a-,>",
      change_working_directory = "~",
    },
  },
  keys = {
    { "<leader>f.", desc = "Yazi: Browse files (cwd)", "<cmd>Yazi<cr>" },
    { "<leader>f/", desc = "Yazi: Browse files (project dir)", "<cmd>Yazi cwd<cr>" },
    { "<leader>f<Up>", desc = "Yazi: Resume the last session", "<cmd>Yazi toggle<cr>" },
  }
}
