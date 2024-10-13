return {
  "jake-stewart/multicursor.nvim",
  config = function()
    require("multicursor-nvim").setup()

    local function highlight(group, definition)
      vim.api.nvim_set_hl(0, group, definition)
    end

    highlight("MultiCursorCursor", { link = "TodoBgFIX" })
    highlight("MultiCursorSign",   { link = "TodoBgFIX" })
    highlight("MultiCursorVisual", { link = "TodoBgWARN" })
    highlight("MultiCursorDisabledCursor", { link = "@text.todo" })
    highlight("MultiCursorDisabledSign",   { link = "@text.todo" })
    highlight("MultiCursorDisabledVisual", { link = "Substitute" })
  end,
  keys = function()
    local mc = require("multicursor-nvim")

    return {
      -- add cursors above/below the main cursor, skipping empty lines
      { mode = { "n", "v" }, "<a-up>", desc = "Add cursor above", function() mc.lineAddCursor(-1) end },
      { mode = { "n", "v" }, "<a-down>", desc = "Add cursor below", function() mc.lineAddCursor(1) end },

      -- add a cursor and jump to the next/previous selection/word under cursor
      { mode = { "n", "v" }, "<c-n>", desc = "Add cursor + jump to next selection/word", function() mc.matchAddCursor(1) end },
      { mode = { "n", "v" }, "<c-p>", desc = "Add cursor + jump to previous selection/word", function() mc.matchAddCursor(-1) end },

      -- jump to the next/previous selection/word under cursor without adding a cursor
      { mode = { "n", "v" }, "<c-a-n>", desc = "Next selection/word w/o adding a cursor", function() mc.matchSkipCursor(1) end },
      { mode = { "n", "v" }, "<c-a-p>", desc = "Previous selection/word w/o adding a cursor", function() mc.matchSkipCursor(-1) end },

      -- jumplist navigation
      { mode = { "n", "v" }, "<c-a-i>", desc = "Next cursor positions in the jumplist", mc.jumpForward },
      { mode = { "n", "v" }, "<c-a-o>", desc = "Previous cursor positions in the jumplist", mc.jumpBackward },

      -- rotate the main cursor
      { mode = { "n", "v" }, "<a-right>", desc = "Next cursor", mc.nextCursor },
      { mode = { "n", "v" }, "<a-left>", desc = "Previous cursor", mc.prevCursor },

      { mode = { "n", "v" }, "å", desc = "First cursor", mc.firstCursor }, -- å -> <a-a>
      { mode = { "n", "v" }, "Ω", desc = "Last cursor", mc.lastCursor },   -- Ω -> <a-z>

      -- delete the main cursor
      { mode = { "n", "v" }, "dx", desc = "Delete cursor", mc.deleteCursor },

      -- align cursor columns
      { mode = { "n", "v" }, "≠", desc = "Align cursors", mc.alignCursors }, -- ≠ -> <a-=>

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

      -- restore cursors after clearing them
      { mode = "n", "©√", desc = "Restore cursors", mc.restoreCursors }, -- ©√ -> <a-g><a-v>

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
