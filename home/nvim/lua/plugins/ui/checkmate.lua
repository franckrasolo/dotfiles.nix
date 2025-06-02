return {
  "bngarren/checkmate.nvim",
  ft = "markdown",
  opts = {
    files = { "todo.md", "TODO.md", "*.todo.md" },
    metadata = {
      done = {
        get_value = function()
          return tostring(os.date("%d %b %Y %H:%M"))
        end,
      },
    },
  },
}
