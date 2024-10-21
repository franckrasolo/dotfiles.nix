return {
  "OXY2DEV/markview.nvim",
  ft = "markdown",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  config = function(_, opts)
    local markview = require("markview")
    markview.setup(opts)

    LazyVim.toggle.map("<leader>um", {
      name = "Markdown Preview",
      get = function()
        return markview.state.enable
      end,
      set = function(enabled)
        if enabled then
          markview.commands.enableAll()
        else
          markview.commands.disableAll()
        end
      end,
    })
  end,
  opts = {
    headings = {
      shift_width = 0,

      heading_1 = {
        style = "label",

        padding_left = " ",
        padding_right = " ",

        corner_right = "",
        corner_right_hl = "decorated_h1_inv",

        icon = "󰼏  ",
        sign = "",
        hl = "decorated_h1",
      },
      heading_2 = {
        style = "label",

        padding_left = " ",
        padding_right = " ",

        corner_right = "",
        corner_right_hl = "decorated_h2_inv",

        icon = "󰎨  ",
        sign = "",
        hl = "decorated_h2",
      },
      heading_3 = {
        style = "label",

        padding_left = " ",
        padding_right = " ",

        corner_right = "",
        corner_right_hl = "decorated_h3_inv",

        icon = "󰼑  ",
        hl = "decorated_h3",
        sign = "",
      },
      heading_4 = {
        style = "label",

        padding_left = " ",
        padding_right = " ",

        corner_right = "",
        corner_right_hl = "decorated_h4_inv",

        icon = "󰎲  ",
        sign = "",
        hl = "decorated_h4",
      },
      heading_5 = {
        style = "label",

        padding_left = " ",
        padding_right = " ",

        corner_right = "",
        corner_right_hl = "decorated_h5_inv",

        icon = "󰼓  ",
        sign = "",
        hl = "decorated_h5",
      },
      heading_6 = {
        style = "label",

        padding_left = " ",
        padding_right = " ",

        corner_right = "",
        corner_right_hl = "decorated_h6_inv",

        icon = "󰎴  ",
        sign = "",
        hl = "decorated_h6",
      },
    },

    code_blocks = {
      enable = true,
      style = "language",

      hl = "dark",

      min_width = 60,
      pad_amount = 3,

      language_names = nil,
      language_direction = "right",

      sign = false,
      sign_hl = nil,
    },

    inline_codes = {
      enable = true,
      hl = "dark",
    },

    block_quotes = {
      enable = true,
      default = {},
      callouts = {},
    },

    horizontal_rules = {},
    hyperlink = {},
    image = {},

    list_items = {
      marker_plus = {
        add_padding = false,
        marker = "•",
        marker_hl = "rainbow2",
      },
      marker_minus = {
        add_padding = false,
        marker = "•",
        marker_hl = "rainbow2",
      },
      marker_star = {
        add_padding = false,
        marker = "•",
        marker_hl = "rainbow2",
      },
    },

    checkboxes = {},

    highlight_groups = {
      {
        group_name = "decorated_h1",
        value = { bg = "#f38ba8", fg = "#313244", bold = true },
      },
      {
        group_name = "decorated_h1_inv",
        value = { fg = "#f38ba8", bold = true },
      },
      {
        group_name = "decorated_h2",
        value = { bg = "#fab387", fg = "#313244", bold = true },
      },
      {
        group_name = "decorated_h2_inv",
        value = { fg = "#fab387", bold = true },
      },
      {
        group_name = "decorated_h3",
        value = { bg = "#f9e2af", fg = "#313244", bold = true },
      },
      {
        group_name = "decorated_h3_inv",
        value = { fg = "#f9e2af", bold = true },
      },
      {
        group_name = "decorated_h4",
        value = { bg = "#a6e3a1", fg = "#313244", bold = true },
      },
      {
        group_name = "decorated_h4_inv",
        value = { fg = "#a6e3a1", bold = true },
      },
      {
        group_name = "decorated_h5",
        value = { bg = "#74c7ec", fg = "#313244", bold = true },
      },
      {
        group_name = "decorated_h5_inv",
        value = { fg = "#74c7ec", bold = true },
      },
      {
        group_name = "decorated_h6",
        value = { bg = "#b4befe", fg = "#313244", bold = true },
      },
      {
        group_name = "decorated_h6_inv",
        value = { fg = "#b4befe", bold = true },
      },

      {
        group_name = "dark",
        value = { bg = "#18182f" },
      },

      {
        group_name = "MarkviewCode",
        value = { bg = "#18182f" },
      },
      {
        group_name = "MarkviewCodeInfo",
        value = { bg = "#18182f", fg = "#939ab7" },
      },
      {
        group_name = "MarkviewInlineCode",
        value = { bg = "#18182f" },
      },

      {
        group_name = "MarkviewIcon1",
        value = { bg = "#18182f", fg = "#ed8796" },
      },
      {
        group_name = "MarkviewIcon2",
        value = { bg = "#18182f", fg = "#f5a97f" },
      },
      {
        group_name = "MarkviewIcon3",
        value = { bg = "#18182f", fg = "#eed49f" },
      },
      {
        group_name = "MarkviewIcon4",
        value = { bg = "#18182f", fg = "#a6da95" },
      },
      {
        group_name = "MarkviewIcon5",
        value = { bg = "#18182f", fg = "#7dc4e4" },
      },
      {
        group_name = "MarkviewIcon6",
        value = { bg = "#18182f", fg = "#b7bdf8" },
      },
    },
  },
}
