return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "harper-ls" } },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("harper_ls", {
        settings = {
          ["harper-ls"] = {
            codeActions = {
              ForceStable = true,
            },
            userDictPath = os.getenv("XDG_CONFIG_HOME") .. "/harper-ls/dictionary.txt",
            fileDictPath = os.getenv("XDG_DATA_HOME") .. "/harper-ls/file_dictionaries",

            -- Severity can be "hint", "information", "warning", or "error".
            diagnosticSeverity = "hint",

            dialect = "British",
            isolateEnglish = false,

            linters = {
              AnA = true,
              AvoidCurses = true,
              CorrectNumberSuffix = true,
              LinkingVerbs = false,
              LongSentences = true,
              Matcher = true,
              MultipleSequentialPronouns = true,
              NumberSuffixCapitalization = true,
              RepeatedWords = true,
              SentenceCapitalization = false,
              Spaces = true,
              SpellCheck = true,
              SpelledNumbers = false,
              TerminatingConjunctions = true,
              UnclosedQuotes = true,
              WrongQuotes = false,
            },
            markdown = {
              IgnoreLinkTitle = false,
            },
          }
        },
      })
    end,
  },
}
