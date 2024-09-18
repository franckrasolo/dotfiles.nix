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
    sort = { "manual", "local", "order", "group", "alphanum", "mod" },
    icons = {
      rules = {
        { pattern = "bookmark commands", icon = "󱚊 ", color = "red" },
        { pattern = "bookmark this", icon = "󱚌 ", color = "yellow" },
        { pattern = "bookmarks", icon = "󰂻 ", color = "green" },
        { pattern = "previous bookmark", icon = "󱚀 ", color = "green" },
        { pattern = "next bookmark", icon = "󱚂 ", color = "green" },
        { pattern = "jumps", icon = "󱕘 ", color = "green" },
        { pattern = "previews", icon = " ", color = "blue" },
      }
    }
  }
}
