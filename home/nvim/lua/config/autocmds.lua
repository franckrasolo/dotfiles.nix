-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "aerospace.toml" },
  command = "!aerospace reload-config",
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "term://*:just *;#toggleterm#*",
  callback = function()
    local close_just_output_with = function(key)
      vim.keymap.set("n", key, function() vim.cmd.wincmd("q") end, { buffer = true, noremap = true })
    end
    close_just_output_with("<esc>")
    close_just_output_with("q")
  end
})

vim.api.nvim_create_autocmd("SessionLoadPost", {
  pattern = "*",
  callback = function()
    local overseer = require("overseer")
    overseer.run_template({ name = "run tests" }, function(task)
      if task then
        task:add_component { "restart_on_save", paths = { vim.fn.getcwd() }, delay = 100 }
      end
    end)
  end
})
