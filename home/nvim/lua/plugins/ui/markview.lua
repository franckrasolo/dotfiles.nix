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

    Snacks.toggle {
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
    }:map("<leader>um")
  end,
  opts = {
    markdown = {
      enable = true,

      headings = {
        shift_width = 0,

        heading_1 = {
          style = "label",

          padding_left = " ",
          padding_right = " ",

          corner_right = "",
          corner_right_hl = "MarkviewPalette1Fg",

          icon = "󰼏  ",
          sign = "",
          sign_hl = "MarkviewHeading1Sign",
          hl = "MarkviewHeading1",
        },
        heading_2 = {
          style = "label",

          padding_left = " ",
          padding_right = " ",

          corner_right = "",
          corner_right_hl = "MarkviewPalette2Fg",

          icon = "󰎨  ",
          sign = "",
          sign_hl = "MarkviewHeading2Sign",
          hl = "MarkviewHeading2",
        },
        heading_3 = {
          style = "label",

          padding_left = " ",
          padding_right = " ",

          corner_right = "",
          corner_right_hl = "MarkviewPalette3Fg",

          icon = "󰼑  ",
          hl = "MarkviewHeading3",
          sign = "",
        },
        heading_4 = {
          style = "label",

          padding_left = " ",
          padding_right = " ",

          corner_right = "",
          corner_right_hl = "MarkviewPalette4Fg",

          icon = "󰎲  ",
          sign = "",
          hl = "MarkviewHeading4",
        },
        heading_5 = {
          style = "label",

          padding_left = " ",
          padding_right = " ",

          corner_right = "",
          corner_right_hl = "MarkviewPalette5Fg",

          icon = "󰼓  ",
          sign = "",
          hl = "MarkviewHeading5",
        },
        heading_6 = {
          style = "label",

          padding_left = " ",
          padding_right = " ",

          corner_right = "",
          corner_right_hl = "MarkviewPalette6Fg",

          icon = "󰎴  ",
          sign = "",
          hl = "MarkviewHeading6",
        },
      },

      horizontal_rules = {},

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

      block_quotes = {
        enable = true,
        default = {},
        callouts = {},
      },

      code_blocks = {
        enable = true,
        style = "language",

        border_hl = "dark",

        min_width = 60,
        pad_amount = 3,

        language_names = nil,
        language_direction = "right",

        sign = false,
        sign_hl = nil,
      },
    },

    markdown_inline = {
      checkboxes = {},
      hyperlinks = {},
      images = {},

      inline_codes = {
        enable = true,
        hl = "dark",
      },
    },
  },
}
