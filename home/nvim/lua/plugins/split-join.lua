return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    -- default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
    use_default_keymaps = false,
    -- node with syntax error will not be formatted
    check_syntax_error = true,
    -- if line after join will be longer than max value, it will not be formatted
    max_join_length = 120,
    -- cursor behavior:
    --   hold  - cursor follows the node/place on which it was called
    --   start - cursor jumps to the first symbol of the node being formatted
    --   end   - cursor jumps to the last symbol of the node being formatted
    cursor_behavior = "hold",
    -- notify about possible problems
    notify = true,
    -- use '.' to repeat an action
    dot_repeat = true,
    -- callback for treesj's error handler
    --   func (err_text, level, ...other_text)
    on_error = nil,
    -- see default language presets in lua/treesj/langs
    -- langs = {},
  },
  keys = {
    { "<leader>rt", desc = "TreeSitter: toggle split/join node", "<cmd>TSJToggle<cr>" },
    { "<leader>rj", desc = "TreeSitter: join node", "<cmd>TSJJoin<cr>" },
    { "<leader>rs", desc = "TreeSitter: split node", "<cmd>TSJSplit<cr>" },
  },
}
