return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "harper-ls" } },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      require("lspconfig").harper_ls.setup {
        settings = {
          ["harper-ls"] = {
            userDictPath = os.getenv("XDG_CONFIG_HOME") .. "/harper-ls/dictionary.txt",
            fileDictPath = os.getenv("XDG_DATA_HOME") .. "/harper-ls/file_dictionaries",

            -- Severity can be "hint", "information", "warning", or "error".
            diagnosticSeverity = "hint",

            linters = {
              an_a = true,
              avoid_curses = true,
              correct_number_suffix = true,
              linking_verbs = false,
              long_sentences = true,
              matcher = true,
              multiple_sequential_pronouns = true,
              number_suffix_capitalization = true,
              repeated_words = true,
              sentence_capitalization = false,
              spaces = true,
              spell_check = true,
              spelled_numbers = false,
              terminating_conjunctions = true,
              unclosed_quotes = true,
              wrong_quotes = false,
            },
          },
        },
      }
    end,
  },
}
