return {
  "johmsalas/text-case.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function(_, opts)
    require("textcase").setup(opts)
    require("telescope").load_extension("textcase")
  end,
  opts = {
    default_keymappings_enabled = false,
  },
  keys = function()
    local textcase = require("textcase")

    local function keymap(char, action, example)
      vim.keymap.set("n", "gaw" .. char,
        function() textcase.current_word(action) end,
        { desc = "Switch current word to " .. example }
      )
    end

    keymap("c", "to_camel_case", "camelCase")
    keymap("C", "to_pascal_case", "PascalCase")
    keymap("p", "to_lower_phrase_case", "lower phrase case")
    keymap("P", "to_upper_phrase_case", "Upper phrase case")
    keymap("s", "to_snake_case", "snake_case")
    keymap("S", "to_constant_case", "CONSTANT_CASE")
    keymap("t", "to_phrase_case", "Phrase case")
    keymap("T", "to_title_case", "Title Case")
    keymap("u", "to_lower_case", "lower case")
    keymap("U", "to_upper_case", "UPPER CASE")
    keymap("-", "to_dash_case", "dash-case")
    keymap(".", "to_dot_case", "dot.case")
    keymap("/", "to_path_case", "path/case")

    return {
      { "gaw", "", desc = "Switch current word to..." },
      { "ga.", desc = "Telescope Text Case", "<cmd>TextCaseOpenTelescope<cr>", mode = { "n", "v" } },
      { "gaq", desc = "Telescope Quick Change", "<cmd>TextCaseOpenTelescopeQuickChange<cr>" },
      { "gal", desc = "Telescope LSP Change", "<cmd>TextCaseOpenTelescopeLSPChange<cr>" },
    }
  end,
}
