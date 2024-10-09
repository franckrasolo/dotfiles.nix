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
          base = "#01010F",
          mantle = "#01010F",
          crust = "#01010F",
        },
      },
      custom_highlights = { Visual = { bg = "#472955" } },
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
