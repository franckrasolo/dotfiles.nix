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

-- automatically open the preview when entering an oil.nvim buffer
vim.api.nvim_create_autocmd("User", {
  pattern = "OilEnter",
  callback = vim.schedule_wrap(function(args)
    local oil = require("oil")
    if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
      oil.open_preview()
    end
  end),
})

return {
  {
    "stevearc/oil.nvim",
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
        border = "rounded",
        max_width = 90,
        max_height = 40,
        padding = 2,
        preview_split = "below",
        win_options = {
          winblend = 0, -- no transparency
        },
      },
      preview_win = {
        max_width = 0.8,
        min_width = 0.65,
        max_height = 0.9,
        min_height = { 60, 0.8 },
      },
      win_options = {
        wrap = true,
        winhighlight = "NormalFloat:AccentFloat,FloatBorder:FloatBorder",
      },
      keymaps = {
        ["g?"] = false,
        ["?"] = "actions.show_help",
        ["~"] = false,
        ["π"] = "actions.preview", -- π -> 'Alt p'
        ["<up>"] = "actions.preview_scroll_up",
        ["<down>"] = "actions.preview_scroll_down",
        ["<left>"] = "actions.preview_scroll_left",
        ["<right>"] = "actions.preview_scroll_right",
        ["<c-c>"] = false,
        ["<c-p>"] = false,
        ["<c-t>"] = false,
        ["q"] = "actions.close",
        ["<esc>"] = "actions.close",
      },
    },
    keys = {
      { "-", desc = "Open parent directory", function() require("oil").toggle_float() end },
    }
  }
}
