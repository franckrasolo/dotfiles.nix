return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.config").setup {
        indent = { enable = true },
      }
    end,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "css",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "graphql",
        "haskell",
        "hcl",
        "html",
        "html_tags",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "jsonc",
        "jsx",
        "just",
        "kotlin",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "nix",
        -- "org",
        "printf",
        "python",
        "regex",
        "rust",
        "sql",
        "sql",
        "terraform",
        "toml",
        "tsx",
        "typescript",
        "xml",
        "yaml",
      })

      vim.list_extend(opts.highlight, {
        additional_vim_regex_highlighting = {
          "plantuml",
        }
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      mode = "topline",
    },
    keys = function()
      local function jump_to_context()
        require("treesitter-context").go_to_context(vim.v.count1)
      end
      return {
        { "[c", jump_to_context, desc = "Jump to context" },
      }
    end
  },
}
