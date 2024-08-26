return {
  name = "run tests",
  builder = function()
    return {
      cmd = { "just", "check" },
      components = {
        { "on_complete_notify", on_change = true },
        { "on_output_quickfix", set_diagnostics = true },
        { "on_output_summarize", max_lines = 10 },
        "on_result_diagnostics",
        { "open_output", direction = "float", focus = true, on_complete = "failure", on_start = "never" },
        "default",
      },
    }
  end,
  condition = {
    filetype = { "jproperties", "json", "just", "kotlin", "lua", "mojo", "python", "rust", "yaml" },
  },
}
