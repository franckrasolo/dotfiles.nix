-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "aerospace.toml" },
  command = "!aerospace reload-config",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("disable_spellcapcheck", { clear = true }),
  pattern = { "text", "gitcommit", "NeogitCommitMessage" },
  callback = function()
    vim.opt_local.spellcapcheck = ''
  end,
})

-- show diagnostics in a floating window instead of virtual text
-- credit: https://youtu.be/3p2n2-eiuZw?t=629 [Harper]
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
  callback = function()
    vim.diagnostic.config {
      float = {
        border = "rounded",
        focus = false,
      },
      virtual_text = false,
    }
  end,
})
