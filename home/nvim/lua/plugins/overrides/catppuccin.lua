local colours = {
  normal = {
    background = "#01010F",
  },

  floating = {
    accent = "#472955",
    background = "#110C1E",
    border = "#7D5A9A",
  },
}

return {
  { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin" } },
  {
    "catppuccin/nvim",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      transparent_background = false,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      no_italic = false,
      no_bold = false,
      no_underline = false,
      color_overrides = {
        macchiato = {
          base = colours.normal.background,
          mantle = colours.normal.background,
          crust = colours.normal.norbackground,
        },
      },
      custom_highlights = {
        FloatBorder = { bg = colours.floating.background, fg = colours.floating.border },
        NormalFloat = { bg = colours.floating.background, blend = 0 },
        Pmenu = { link = "NormalFloat" },
        PmenuSbar = { link = "NormalFloat" },
        PmenuSel = { bg = colours.floating.accent },
        PmenuThumb = { link = "PmenuSel" },
        TelescopeNormal = { link = "NormalFloat" },
        Visual = { link = "PmenuSel" },
      },
      default_integrations = true,
      integrations = {
        dadbod_ui = true,
        dap = true,
        dap_ui = true,
        diffview = true,
        native_lsp = {
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          inlay_hints = {
            background = true,
          },
        },
        overseer = true,
        rainbow_delimiters = true,
        telescope = {
          enabled = true,
          style = "classic",
        }
      },
    }
  }
}
