return {
  "folke/which-key.nvim",
  opts = {
    preset = "modern",
    win = {
      -- allow the popup to overlap with the cursor so that options are more easily discoverable
      no_overlap = false,
      padding = { 1, 1 }, -- padding: { top/bottom, right/left }
      title = true,
      title_pos = "center",
    },
    layout = {
      spacing = 1, -- spacing between columns
    },
    icons = {
      rules = {
        { pattern = "previews", icon = " ", color = "blue" },
      }
    }
  }
}
