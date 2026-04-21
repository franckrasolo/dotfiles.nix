return {
  "ThePrimeagen/refactoring.nvim",
  config = function(_, opts)
    require("refactoring").setup(opts)
    -- NOTE: on 01 Oct 2025, commit 7bcb7f7 of refactoring.nvim removed the telescope
    -- extension, so we just skip loading it entirely. The pick function used by this
    -- extra already falls back to refactoring.select_refactor() / vim.ui.select.
  end,
}
