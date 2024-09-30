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
      -- add cursors above/below the main cursor, skipping empty lines
      { mode = { "n", "v" }, "<a-up>", desc = "Add cursor above", function() mc.lineAddCursor(-1) end },
      { mode = { "n", "v" }, "<a-down>", desc = "Add cursor below", function() mc.lineAddCursor(1) end },

      -- add a cursor and jump to the next word under cursor
      { mode = { "n", "v" }, "<c-n>", desc = "Add cursor + jump to next word", function() mc.addCursor("*") end },

      -- jump to the next word under cursor but do not add a cursor
      { mode = { "n", "v" }, "<c-s>", desc = "Next word w/o adding a cursor", function() mc.skipCursor("*") end },

      -- rotate the main cursor
      { mode = { "n", "v" }, "<a-right>", desc = "Next cursor", mc.nextCursor },
      { mode = { "n", "v" }, "<a-left>", desc = "Previous cursor", mc.prevCursor },

      { mode = { "n", "v" }, "å", desc = "First cursor", mc.firstCursor }, -- å -> <a-a>
      { mode = { "n", "v" }, "Ω", desc = "Last cursor", mc.lastCursor },   -- Ω -> <a-z>

      -- delete the main cursor
      { mode = { "n", "v" }, "dx", desc = "Delete cursor", mc.deleteCursor },

      -- align cursor columns
      { mode = "v", "≠", desc = "Align cursors", mc.alignCursors }, -- ≠ -> <a-=>

      -- split visual selections by regex
      { mode = "v", "/", desc = "Split visual selections by regex", mc.splitCursors },

      -- append/insert for each line of visual selections
      { mode = "v", "È", desc = "Insert before selections", mc.insertVisual }, -- È -> <a-I>
      { mode = "v", "Å", desc = "Append after selections", mc.appendVisual },  -- Å -> <a-A>

      -- match new cursors within visual selections by regex
      { mode = "v", "µ", desc = "Regex match new cursors within selections", mc.matchCursors }, -- µ -> <a-m>

      -- rotate contents of visual selections
      { mode = "v", "<c-/>", desc = "Rotate selections clockwise", function() mc.transposeCursors(1) end },
      { mode = "v", "<c-\\>", desc = "Rotate selections anti-clockwise", function() mc.transposeCursors(-1) end },

      -- clone every cursor and disable the originals
      { mode = { "n", "v" }, "ç", desc = "Clone cursors", mc.duplicateCursors }, -- ç -> <a-c>

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
