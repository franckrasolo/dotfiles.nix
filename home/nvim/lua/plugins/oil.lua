local always_hidden = require("pl.List") {
  "..",
  ".astro",
  ".direnv",
  ".git",
  ".gradle",
  ".idea",
  ".pnpm-store",
  ".pytest-cache",
  ".pytest_cache",
  ".ruff_cache",
  ".turbo",
  ".DS_Store",
  "__pycache__",
  "bin",
  "build",
  "dist",
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
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
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
        ["π"] = "actions.preview", -- π -> 'Alt p'
        ["<C-c>"] = false,
        ["<C-p>"] = false,
        ["<C-t>"] = false,
        ["q"] = "actions.close",
        ["<esc>"] = "actions.close",
      },
    },
    keys = {
      { "-", desc = "Open parent directory", function() require("oil").toggle_float() end },
    }
  }
}
