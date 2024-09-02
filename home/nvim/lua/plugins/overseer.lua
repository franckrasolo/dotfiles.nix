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
