return {
  {
    "nvim-zh/colorful-winsep.nvim",
    event = "WinLeave",
    opts = {
      border = "rounded",
      colors = { "#f9e2af" },
      excluded_ft = { "TelescopePrompt", "mason" },
      animate = {
        enabled = false,
      },
      indicator_for_2wins = {
        position = "center",
        symbols = {
          start_left = "🮥",
          end_left = "🮥",
          start_down = "🮧 ",
          end_down = "🮧 ",
          start_up = "🮦",
          end_up = "🮦",
          start_right = "🮤",
          end_right = "🮤",
        },
      },
    },
  },
  {
    "sindrets/winshift.nvim",
    opts = {
      highlight_moving_win = true, -- highlight the window being moved
      focused_hl_group = "Visual", -- highlight group used for the window being moved
      moving_win_options = {
        -- options applied to the current window only while it's being moved
        wrap = false,
        cursorline = false,
        cursorcolumn = false,
        colorcolumn = "",
      },
      keymaps = {
        disable_defaults = false,
        win_move_mode = {
          ["h"] = "left",
          ["j"] = "down",
          ["k"] = "up",
          ["l"] = "right",
          ["H"] = "far_left",
          ["J"] = "far_down",
          ["K"] = "far_up",
          ["L"] = "far_right",
          ["<left>"] = "left",
          ["<down>"] = "down",
          ["<up>"] = "up",
          ["<right>"] = "right",
          ["<S-left>"] = "far_left",
          ["<S-down>"] = "far_down",
          ["<S-up>"] = "far_up",
          ["<S-right>"] = "far_right",
        },
      },
    },
    keys = {
      { "<leader>wz", "<cmd>WinShift<cr>", desc = "Move the current window" },
    },
  },
}
