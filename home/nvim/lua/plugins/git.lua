return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.current_line_blame = true
      opts.current_line_blame_formatter = "<abbrev_sha> — <author_time:%a %d/%m/%Y %H:%M:%S> — <author>: <summary>  "
      opts.current_line_blame_opts = {
        delay = 0,
        ignore_whitespace = true,
        virt_text_pos = "right_align"
      }

      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0A4B0A" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1B375F" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#494B4B" })
      vim.api.nvim_set_hl(0, "DiffText", { bg = "#1B375F", fg = "#FFFFFF", italic = true })
      vim.api.nvim_set_hl(0, "GitSignsAddPreview", { bg = "#0A4B0A" })
      vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { bg = "#494B4B" })
      vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#464B5D", italic = true })

      vim.keymap.set("n", "<C-x>",
          function()
            return (vim.api.nvim_win_get_option(0, "diff") and "<C-w>h<C-w>c") or "<Nop>"
          end,
          { desc = "Close the active diff", expr = true, unique = true, silent = true }
      )
    end
  },
}
