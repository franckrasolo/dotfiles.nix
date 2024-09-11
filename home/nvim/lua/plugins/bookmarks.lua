vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function()
    vim.wo.number = true
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  pattern = { "*" },
  callback = function()
    require("bookmarks").setup()
    require("bookmarks.sign").refresh_signs()
  end,
})

return {
  "LintaoAmons/bookmarks.nvim",
  lazy = false,
  dependencies = {
    { "nvim-telescope/telescope.nvim" },
    { "stevearc/dressing.nvim" }
  },
  opts = {
    json_db_path = vim.fs.normalize(vim.fn.stdpath("data") .. "/bookmarks.db.json"),
    signs = {
      mark = { icon = " ", color = "#34bf91", line_bg = "#0E2E21" },
      desc_format = function(desc)
        return " " .. desc
      end
    },
    picker = {
      -- sort logic:
      --   name: string, built-in implementations: "created_at", "last_visited"
      --   custom: function(bookmarks: Bookmarks.Bookmark[]): nil
      sort_by = "created_at",
    },
    -- optional: backup the json db file when a new neovim session started and you try to mark a place
    -- you can find the file under the same folder
    enable_backup = true,
    -- optional: show the result of the calibration when you try to calibrate the bookmarks
    show_calibrate_result = true,
    -- optional: auto calibrate the current buffer when you enter it
    auto_calibrate_cur_buf = true,

    treeview = {
      bookmark_format = function(bookmark)
        if bookmark.name ~= "" then return bookmark.name else return "[No Name]" end
      end,
      keymap = {
        quit = { "q", "<esc>" },
        refresh = "R",
        create_folder = "a",
        tree_cut = "x",
        tree_paste = "p",
        collapse = "o",
        delete = "d",
        active = "s",
        copy = "c",
      },
    },
    hooks = {
      {
        ---a sample hook that changes the working directory when navigating to a bookmark
        ---@param bookmark Bookmarks.Bookmark
        ---@param projects Bookmarks.Project[]
        callback = function(bookmark, projects)
          local project_path

          for _, p in ipairs(projects) do
            if p.name == bookmark.location.project_name then
              project_path = p.path
            end
          end
          if project_path then
            vim.cmd("cd " .. project_path)
          end
        end,
      },
    },
  },
  keys = function()
    local api = require("bookmarks.api")
    local picker = require("bookmarks.adapter.picker")

    local function browse_bookmarks(args)
      local picker_fn = args.picker_fn or picker.pick_bookmark
      local open_with = args.open_with or "edit"
      local all_lists = args.all_lists or args.all_lists ~= nil

      return function()
        picker_fn(
            function(bookmark)
              api.goto_bookmark(bookmark, { open_method = open_with })
            end,
            { all = all_lists }
        )
      end
    end

    local function keymap(key_binding)
      return vim.tbl_extend("force", { mode = { "n", "v" } }, key_binding)
    end

    return {
      keymap { "<leader>j", desc = "jumps", "" },
      keymap { "<leader>j_", desc = "Bookmark commands...", "<cmd>BookmarksCommands<cr>" },
      keymap { "<leader>j,", desc = "Bookmarks for the current project...", browse_bookmarks {
        picker_fn = picker.pick_bookmark_of_current_project
      } },
      keymap { "<leader>j.", desc = "Bookmarks for the active list...", browse_bookmarks {} },
      keymap { "<leader>j/", desc = "Bookmarks across all lists...", browse_bookmarks {
        picker_fn = picker.pick_bookmark,
        open_with = "edit",
        all_lists = true
      } },
      keymap { "<leader>j ", desc = "Rename/Bookmark this buffer position to the active list", "<cmd>BookmarksMark<cr>" },
      keymap { "<leader>j[", desc = "Previous bookmark in the current project", "<cmd><cr>" },
      keymap { "<leader>j]", desc = "Next bookmark in the current project", "<cmd><cr>" },
    }
  end
}
