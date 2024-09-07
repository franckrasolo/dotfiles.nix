vim.api.nvim_create_autocmd("SessionLoadPost", {
  once = true,
  pattern = { "*.go", "*.kt", "*.lua", "*.mojo", "*.moon", "*.py", "*.rs" },
  callback = function()
    local overseer = require("overseer")
    overseer.run_template({ name = "run tests" }, function(task)
      if task then
        task:add_component { "restart_on_save", paths = { vim.fn.getcwd() }, delay = 100 }
      end
    end)
  end
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = {
    "term://*:cargo *;#toggleterm#*",
    "term://*:just *;#toggleterm#*",
  },
  callback = function()
    local close_toggleterm_window_with = function(key)
      vim.keymap.set("n", key, function() vim.cmd.wincmd("q") end, { buffer = true, noremap = true })
    end
    close_toggleterm_window_with("<C-f>")
    close_toggleterm_window_with("<esc>")
    close_toggleterm_window_with("q")
  end
})

return {
  "stevearc/overseer.nvim",
  opts = {
    strategy = {
      "toggleterm",
      use_shell = false,
      direction = "horizontal",
      open_on_start = false,
      -- command to run with `use_shell` when the terminal is created and before starting the task
      on_create = nil,
      auto_scroll = false,
      close_on_exit = false,
      -- close the toggleterm window without deleting the terminal buffer
      -- only if the successful task's exit code is 0
      quit_on_exit = "success",
      -- mirrors the toggleterm "hidden" parameter, and keeps the task from
      -- being rendered in the toggleable window
      hidden = false,
      highlights = nil,
    },
    templates = {
      "builtin",
      "user.run_tests",
    },
    task_list = {
      default_detail = 2,
      direction = "right",
      min_width = { 25, 0.225 },
      bindings = {
        ["="] = "IncreaseDetail",
        ["-"] = "DecreaseDetail",
        ["<C-=>"] = "IncreaseAllDetail",
        ["<C-->"] = "DecreaseAllDetail",
        ["<C-u>"] = "ScrollOutputUp",
        ["<C-d>"] = "ScrollOutputDown",
        ["<Down>"] = "NextTask",
        ["<Left>"] = "PrevTask",
        ["<Right>"] = "NextTask",
        ["<Up>"] = "PrevTask",
        ["<esc>"] = "Close",
        ["q"] = "Close",
      },
    },
  },
}
