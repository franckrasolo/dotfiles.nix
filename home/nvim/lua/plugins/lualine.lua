return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "catppuccin/nvim" },
  config = function(_, opts)
    table.remove(opts.sections.lualine_c)
    require("lualine").setup(opts)
  end,
  opts = {
    options = {
      icons_enabled = true,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
    },
    theme = "catppuccin",
    sections = {
      lualine_a = { { "mode", icon = "", padding = { left = 1, right = 0 } } },
      lualine_b = {},
      lualine_c = {
        LazyVim.lualine.root_dir(),
        {
          "diagnostics",
          symbols = {
            error = LazyVim.config.icons.diagnostics.Error,
            warn = LazyVim.config.icons.diagnostics.Warn,
            info = LazyVim.config.icons.diagnostics.Info,
            hint = LazyVim.config.icons.diagnostics.Hint,
          },
        },
        { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
        { LazyVim.lualine.pretty_path() },
      },
      lualine_y = { { "branch", padding = { left = 0, right = 1 } }, "encoding" },
      lualine_z = {
        { "location", padding = { left = 1, right = 1 } },
        { "progress", padding = { left = 1, right = 1 } },
      },
    },
  }
}
