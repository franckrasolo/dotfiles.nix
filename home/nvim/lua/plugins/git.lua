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

      vim.api.nvim_set_hl(0, "DiffAdd", { bg = "#0E2E21" })
      vim.api.nvim_set_hl(0, "DiffChange", { bg = "#1A345A" })
      vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#471613" })
      vim.api.nvim_set_hl(0, "DiffText", { bg = "#D4CF94", fg = "#1A345A", bold = true, italic = true })

      vim.api.nvim_set_hl(0, "GitSignsAddLn", { bg = "#0E2E21" })
      vim.api.nvim_set_hl(0, "GitSignsAddPreview", { bg = "#0E2E21" })
      vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { bg = "#471613" })
      vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6C738C", italic = true })

      vim.api.nvim_set_hl(0, "GitSignsAddInline", { bg = "#D4CF94", fg = "#0E2E21", bold = true, italic = true })
      vim.api.nvim_set_hl(0, "GitSignsChangeInline", { bg = "#D4CF94", fg = "#0E2E21", bold = true, italic = true })
      vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { bg = "#D4CF94", fg = "#471613", bold = true, italic = true })

      local close_diff = function()
        return (vim.api.nvim_win_get_option(0, "diff") and "<C-w>h<C-w>c") or "<Nop>"
      end
      vim.keymap.set("n", "<leader>gx", close_diff, { desc = "Close Diff", expr = true })
    end
  },
}
