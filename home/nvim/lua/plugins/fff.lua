return {
  "dmtrKovalenko/fff",
  lazy = false, -- this plugin lazy-initialises itself
  build = function()
    -- downloads a prebuilt binary or falls back to cargo build
    require("fff.download").download_or_build_binary()
  end,
  opts = {
    debug = {
      enabled = true,
      show_scores = true,
    },
  },
  keys = function()
    local fff = require("fff")
    return {
      { "ff", fff.find_files, desc = "[fff] Find files" },
      { "fg", fff.live_grep, desc = "[fff] Grep files" },
      {
        "fz",
        function() fff.live_grep { grep = { modes = { "fuzzy", "plain" } } } end,
        desc = "[fff] Live fuzzy grep",
      },
      {
        "fw",
        fff.live_grep_under_cursor,
        desc = "[fff] Search current word / selection",
        mode = { "n", "x" },
      },
    }
  end,
}
