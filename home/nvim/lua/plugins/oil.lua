local always_hidden = require("pl.List") {
  "..",
  ".direnv",
  ".git",
  ".gradle",
  ".idea",
  ".pnpm-store",
  ".pytest-cache",
  ".pytest_cache",
  ".ruff_cache",
  ".DS_Store",
  "__pycache__",
  "bin",
  "build",
  "node_modules",
  "venv",
}
return {
  {
    "stevearc/oil.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      columns = { "icon" },
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return always_hidden:contains(name)
        end,
      },
      float = {
        padding = 2,
        max_width = 80,
        max_height = 20,
      },
      win_options = {
        wrap = true,
      },
      keymaps = {
        ["g?"] = false,
        ["?"] = "actions.show_help",
        ["~"] = false,
        ["<C-c>"] = false,
        ["<C-t>"] = false,
        ["q"] = "actions.close",
        ["<esc>"] = "actions.close",
      },
    },
    keys = {
      { "-", function() require("oil").toggle_float() end, desc = "Open parent directory" },
    }
  }
}
