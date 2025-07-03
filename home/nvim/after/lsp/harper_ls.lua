---@type vim.lsp.Config
return {
  cmd = { "harper-ls", "--stdio" },
  root_markers = { ".git" },

  filetypes = {
    "gitcommit",
    "NeogitCommitMessage",
    "html",
    "lua",
    "markdown",
    "nix",
    "plaintext",
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
      userDictPath = vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
      fileDictPath = vim.fn.getcwd() .. "/.harper",
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
        SpellCheck = true,
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
}
