return {
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "gbprod/yanky.nvim", lazy = true },

  {
    "echasnovski/mini.move",
    opts = {
      mappings = {
        -- move visual selection in visual mode
        left = "<S-Left>",
        right = "<S-Right>",
        down = "<S-Down>",
        up = "<S-Up>",

        -- move current line in normal mode
        line_left = "<S-Left>",
        line_right = "<S-Right>",
        line_down = "<S-Down>",
        line_up = "<S-Up>",
      },
    },
  },
  {
    "mistweaverco/kulala.nvim",
    version = "*", --latest release
    opts = {
      winbar = true,
      scratchpad_default_contents = {
        "#",
        "# Examples",
        "#",
        "",
        "# @name example_1",
        "GET https://xkcd.com/info.0.json",
        "",
        "###",
        "",
        "@AUTH_USERNAME=my_username",
        "",
        "# @name example_2",
        "POST https://httpbin.org/post HTTP/1.1",
        "accept: application/json",
        "content-type: application/json",
        "",
        "{",
        '  "baz": "qux"',
        "}",
      },
    },
    keys = {
      { "<leader>Ra", desc = "Open scratchpad",
        function()
          require("kulala").scratchpad()
        end,
        { noremap = true, silent = true }
      },
      { "<leader>Rb", desc = "Open scratchpad (empty)",
        function()
          vim.cmd.edit(require("kulala.globals").SCRATCHPAD_ID)
          vim.bo.buftype  = "nofile"
          vim.bo.filetype = "http"
        end,
        { noremap = true, silent = true }
      },
      { "<leader>Rc", desc = "Close scratchpad",
        function()
          require("kulala").close()
          vim.cmd.bdelete { args = { require("kulala.globals").SCRATCHPAD_ID }, bang = true }
        end,
        { noremap = true, silent = true }
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- recommended
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            files = {
              -- would not be required if rust-analyzer honored .gitignore
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                ".idea",
                "bin",
                "node_modules",
                "target",
                "venv",
              }
            }
          }
        }
      }
    }
  },
}
