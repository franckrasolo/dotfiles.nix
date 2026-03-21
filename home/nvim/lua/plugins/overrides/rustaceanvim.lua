return {
  "mrcjkb/rustaceanvim",
  version = "*",
  opts = {
    server = {
      default_settings = {
        ["rust-analyzer"] = {
          files = {
            -- would not be required if rust-analyzer honored .gitignore
            excludeDirs = {
              ".devenv",
              ".direnv",
              ".git",
              ".github",
              ".gitlab",
              ".idea",
              ".pnpm",
              "bin",
              "node_modules",
              "target",
              "venv",
              ".venv",
            }
          }
        }
      },
    },
  },
}
