return {
  -- add packages (e.g. formatting, linting, debug adapter)
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "ktlint" } },
  },
  -- formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = { kotlin = { "ktlint" } },
    },
  },
  -- linting
  {
    "mfussenegger/nvim-lint",
    optional = true,
    dependencies = "mason-org/mason.nvim",
    opts = {
      linters_by_ft = { kotlin = { "ktlint" } },
    },
  },
  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "kotlin" } },
  },
  -- snippets
  {
    -- "franckrasolo/luasnip4k.nvim",
    dir = "~/dev/Kotlin/luasnip4k",
    name = "luasnip4k.nvim",
    dev = true,
  },

  vim.lsp.config("kotlin_lsp", {
    -- language server options
    single_file_support = true,
  }),

  -- enable Kotlin's official language server by JetBrains
  vim.lsp.enable("kotlin_lsp"),
}
