return {
  "rmagatti/goto-preview",
  event = "BufEnter",
  config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
  keys = function()
    local plugin = require("goto-preview")
    return {
      { "<leader>i", "", desc = "previews" },
      { "<leader>id", desc = "Preview definition", plugin.goto_preview_definition },
      { "<leader>iD", desc = "Preview declaration", plugin.goto_preview_declaration },
      { "<leader>ii", desc = "Preview implementation", plugin.goto_preview_implementation },
      { "<leader>it", desc = "Preview type definition", plugin.goto_preview_type_definition },
      { "<leader>ir", desc = "Preview references", plugin.goto_preview_references },
      { "<leader>ix", desc = "Close all previews", plugin.close_all_win },
    }
  end,
}
