return {
  "marko-cerovac/material.nvim",
  config = function()
    require("lualine").setup {
      options = { theme = "material" }
    }

    require("material").setup {
      high_visibility = {
        darker = true
      },
      disable = {
        background  = false, -- use the terminal background instead
        term_colors = false, -- do not change terminal colours
        eob_lines   = false  -- hide end-of-buffer lines
      },

      custom_colors = function(colors)
        colors.editor.bg = "#000700"
        colors.editor.active = colors.editor.bg
        colors.editor.disabled = colors.editor.selection -- "#090A0C"
        colors.editor.accent = colors.main.darkyellow

        colors.backgrounds.sidebars = colors.editor.bg
        colors.backgrounds.floating_windows = colors.editor.bg
        --colors.backgrounds.non_current_windows = colors.editor.bg_alt
        colors.backgrounds.non_current_windows = colors.editor.bg
      end,

      plugins = {
         "gitsigns",
         "indent-blankline",
         "nvim-cmp",
         "nvim-navic",
         "nvim-web-devicons",
         "telescope",
         "trouble",
         "which-key",
      },

      lualine_style = "stealth",
    }

    vim.cmd("colorscheme material-deep-ocean")
  end
}
