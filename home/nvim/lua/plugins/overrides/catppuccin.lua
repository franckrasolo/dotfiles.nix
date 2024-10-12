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

-- credit: https://stackoverflow.com/a/73931737/1189538
local function show_win_options()
  local win_number = vim.api.nvim_get_current_win()
  local v = vim.wo[win_number]
  local all_options = vim.api.nvim_get_all_options_info()
  local result = ""

  for key, val in pairs(all_options) do
    if val.global_local == false and val.scope == "win" then
      result = result .. "\n" .. key .. "=" .. tostring(v[key] or "<not set>")
    end
  end

  print(result)
end

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
        AccentFloat = { bg = colours.floating.background },
        FloatBorder = { bg = colours.floating.background, fg = colours.floating.border },
        NoicePopup = { link = "AccentFloat" },
        NormalFloat = { bg = colours.normal.background, blend = 0 },
        Pmenu = { link = "AccentFloat" },
        PmenuSbar = { link = "AccentFloat" },
        PmenuSel = { bg = colours.floating.accent },
        PmenuThumb = { link = "PmenuSel" },
        TelescopeNormal = { link = "AccentFloat" },
        Visual = { link = "PmenuSel" },
        WhichKey = { link = "AccentFloat" },
        WhichKeyNormal = { link = "AccentFloat" },
        WhichKeyTitle = { link = "FloatBorder" },
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
        },
      },
    },
    keys = {
      { ",.", desc = "Current window options", show_win_options },
    },
  },
}
