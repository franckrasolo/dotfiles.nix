return {
  {
    "stevearc/oil.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      columns = { "icon" },
      keymaps = {
        ["g?"] = false,
        ["?"] = "actions.show_help",
        ["~"] = false,
        ["<C-c>"] = false,
        ["<C-t>"] = false,
        ["q"] = "actions.close",
        ["<esc>"] = "actions.close",
      },
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 2,
        max_width = 80,
        max_height = 20,
      }
    },
    keys = {
      { "-", function() require("oil").toggle_float() end, desc = "Open parent directory" },
    }
  }
}
