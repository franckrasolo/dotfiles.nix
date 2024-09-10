return {
  { "akinsho/bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  { "gbprod/yanky.nvim", lazy = true },

  { "mistweaverco/kulala.nvim", version = "*" --[[latest release]] },
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
