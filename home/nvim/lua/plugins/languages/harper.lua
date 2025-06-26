return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      -- toggle inlay hints with <leader>uh in LazyVim instead
      inlay_hints = { enabled = false },

      servers = {
        harper_ls = {
          autostart = false,
          enabled = true,
        },
      },
    },
  },

  ---@type vim.lsp.Config
  vim.lsp.config("harper_ls", {
    autostart = false,
    cmd = { "harper-ls", "--stdio" },
    root_markers = { ".git" },

    filetypes = {
      "gitcommit",
      "NeogitCommitMessage",
      "html",
      "lua",
      "markdown",
      "nix",
      "python",
      "text",
      "toml",
    },

    settings = {
      ["harper-ls"] = {
        codeActions = {
          ForceStable = true,
        },

        -- severity can be "hint", "information", "warning", or "error"
        diagnosticSeverity = "information", -- more visible than "hint"
        dialect = "British",
        isolateEnglish = false,

        -- userDictPath = vim.o.spellfile,
        userDictPath = os.getenv("XDG_CONFIG_HOME") .. "/harper-ls/dictionary.txt",
        fileDictPath = os.getenv("XDG_DATA_HOME") .. "/harper-ls/file_dictionaries",
        maxFileLength = 120000,

        linters = {
          AnA = true,
          AvoidCurses = true,
          BoringWords = false,
          CommaFixes = false,               -- https://github.com/Automattic/harper/issues/1097
          CorrectNumberSuffix = true,
          Dashes = false,
          HowTo = false,
          LinkingVerbs = false,
          LongSentences = false,
          Matcher = true,
          MultipleSequentialPronouns = true,
          NumberSuffixCapitalization = true,
          PhrasalVerbAsCompoundNoun = false,
          RepeatedWords = true,
          SentenceCapitalization = false,   -- https://github.com/Automattic/harper/issues/1056
          Spaces = true,
          SpellCheck = false,
          SpelledNumbers = false,
          TerminatingConjunctions = true,
          ToDoHyphen = false,
          UnclosedQuotes = true,
          UseGenitive = true,
          WrongQuotes = true,               -- enable for proper British quotes
        },

        markdown = {
          IgnoreLinkTitle = false,
        },
      },
    },
  }),

  vim.lsp.enable("harper_ls"),

  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      -- stop harper_ls clients with empty settings
      if client and client.name == "harper_ls" and next(client.settings) == nil then
        vim.lsp.stop_client(client.id, true)
      end
    end
  })
}
