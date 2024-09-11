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

      local function highlight(group, attributes)
        vim.api.nvim_set_hl(0, group, attributes)
      end

      highlight("DiffAdd", { bg = "#0E2E21" })
      highlight("DiffChange", { bg = "#1A345A" })
      highlight("DiffDelete", { bg = "#471613" })
      highlight("DiffText", { bg = "#D4CF94", fg = "#1A345A", bold = true, italic = true })

      highlight("GitSignsAddLn", { bg = "#0E2E21" })
      highlight("GitSignsAddPreview", { bg = "#0E2E21" })
      highlight("GitSignsDeletePreview", { bg = "#471613" })
      highlight("GitSignsCurrentLineBlame", { fg = "#6C738C", italic = true })

      highlight("GitSignsAddInline", { bg = "#D4CF94", fg = "#0E2E21", bold = true, italic = true })
      highlight("GitSignsChangeInline", { bg = "#D4CF94", fg = "#0E2E21", bold = true, italic = true })
      highlight("GitSignsDeleteInline", { bg = "#D4CF94", fg = "#471613", bold = true, italic = true })

      local default_on_attach = opts.on_attach
      opts.on_attach = function(buffer)
        default_on_attach(buffer)
        local function close_diff()
          return (vim.api.nvim_win_get_option(0, "diff") and "<C-w>h<C-w>c") or ""
        end
        vim.keymap.set("n", "<leader>ghc", close_diff, { buffer = buffer, desc = "Close Diff", expr = true })
      end
      vim.keymap.set("n", "<leader>gx", close_diff, { desc = "Close Diff", expr = true })
    end
  },
}
