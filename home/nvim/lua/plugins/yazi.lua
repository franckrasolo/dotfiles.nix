return {
  "mikavilpas/yazi.nvim",
  event = "VeryLazy",
  opts = {
    keymaps = {
      show_help = "<C-h>",
      open_file_in_tab = false,
      grep_in_directory = "<C-A-/>",
      replace_in_directory = "<C-A-,>",
    },
  },
  keys = {
    { "<leader>f.", desc = "Browse files (cwd)", "<cmd>Yazi<cr>" },
    { "<leader>f/", desc = "Browse files (project dir)", "<cmd>Yazi cwd<cr>" },
    { "<leader>f<Up>", desc = "Resume the last Yazi session", "<cmd>Yazi toggle<cr>" },
  }
}
