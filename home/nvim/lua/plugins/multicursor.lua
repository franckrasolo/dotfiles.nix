return {
  "jake-stewart/multicursor.nvim",
  config = function()
    require("multicursor-nvim").setup()

    vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "TodoBgFIX" })
    vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "TodoBgWARN" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "@text.todo" })
    vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Substitute" })
  end,
  keys = function()
    local mc = require("multicursor-nvim")

    return {
      -- add cursors above/below the main cursor
      { mode = { "n", "v" }, "<a-up>", desc = "Add cursor above", function() mc.addCursor("k") end },
      { mode = { "n", "v" }, "<a-down>", desc = "Add cursor below", function() mc.addCursor("j") end },

      -- add a cursor and jump to the next word under cursor
      { mode = { "n", "v" }, "<c-n>", desc = "Add cursor + jump to next word", function() mc.addCursor("*") end },

      -- jump to the next word under cursor but do not add a cursor
      { mode = { "n", "v" }, "<c-s>", desc = "Next word w/o adding a cursor", function() mc.skipCursor("*") end },

      -- rotate the main cursor
      { mode = { "n", "v" }, "<a-right>", desc = "Next cursor", mc.nextCursor },
      { mode = { "n", "v" }, "<a-left>", desc = "Previous cursor", mc.prevCursor },

      { mode = { "n", "v" }, "<a-a>", desc = "First cursor", mc.firstCursor },
      { mode = { "n", "v" }, "<a-z>", desc = "Last cursor", mc.lastCursor },

      -- delete the main cursor
      { mode = { "n", "v" }, "dx", desc = "Delete cursor", mc.deleteCursor },

      -- align cursor columns
      { "<a-=>", desc = "Align cursors", mc.alignCursors },

      -- split visual selections by regex
      { mode = "v", "/", desc = "Split visual selections by regex", mc.splitCursors },

      -- append/insert for each line of visual selections
      { mode = "v", "<a-I>", desc = "Insert before selections", mc.insertVisual },
      { mode = "v", "<a-A>", desc = "Append after selections", mc.appendVisual },

      -- match new cursors within visual selections by regex
      { mode = "v", "<a-M>", desc = "Regex match new cursors within selections", mc.matchCursors },

      -- rotate contents of visual selections
      { mode = "v", "<c-/>", desc = "Rotate selections clockwise", function() mc.transposeCursors(1) end },
      { mode = "v", "<c-\\>", desc = "Rotate selections anti-clockwise", function() mc.transposeCursors(-1) end },

      { mode = { "n", "v" }, "<c-q>", desc = "Stop cursors / Add cursor",
        function()
          if mc.cursorsEnabled() then
            -- stop other cursors from moving: allows the repositioning of the main cursor
            mc.disableCursors()
          else
            mc.addCursor()
          end
        end
      },

      { mode = { "n", "v" }, "<esc>", desc = "Enable / Clear cursors",
        function()
          if not mc.cursorsEnabled() then
            mc.enableCursors()
          elseif mc.hasCursors() then
            mc.clearCursors()
          else
            -- default <esc> handler
            vim.cmd([[execute "normal! \<ESC>"]])
          end
        end
      },
    }
  end
}
