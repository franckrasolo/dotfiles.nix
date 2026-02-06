return {
  "echaya/neowiki.nvim",
  ---@type neowiki.Config
  opts = {
    wiki_dirs = {
      -- { name = "current repo | <cwd>/.wiki", path = vim.uv.cwd() .. "/.wiki" },
      -- { name = "current repo | <cwd>/pages/blog", path = vim.uv.cwd() .. "/pages/blog" },
      -- { name = "current repo | <cwd>/pages/docs", path = vim.uv.cwd() .. "/pages/docs" },
      { name = "dotfiles.nix | <DOTFILES_REPO>/.wiki", path = "~/dev/dotfiles.nix/.wiki" },
      { name = "personal     | <XDG_DATA_HOME>/wiki", path = os.getenv("XDG_DATA_HOME") .. "/wiki" },
    },

    index_file = "index.md",

    gtd = {
      -- set to false to disable the progress percentage virtual text
      show_gtd_progress = true,
      -- highlight group to use for the progress virtual text
      gtd_progress_hl_group = "Comment",
    },

    floating_wiki = {
      open = {
        relative = "editor",
        width = 0.9,
        height = 0.9,
        border = "rounded",
      },

      -- defines the style within the window after it's created
      style = {},
    },

    -- setting a keymap to `false` or an empty string will disable it
    keymaps = {
      -- [normal mode] follows the link under the cursor
      -- [visual mode] creates a link from the selection
      action_link = "<CR>",
      action_link_vsplit = "<S-CR>",
      action_link_split = "<C-CR>",

      -- jumps to the next link in the buffer
      next_link = "<Tab>",
      -- jumps to the previous link in the buffer
      prev_link = "<S-Tab>",
      -- jumps to the index page of the current wiki
      jump_to_index = "<BS>",

      -- renames the current wiki page and updates backlinks
      rename_page = "<leader>Wr",
      -- deletes the current wiki page and updates backlinks
      delete_page = "<leader>Wd",

      -- inserts a link to another wiki page
      insert_link = "<leader>Wi",
      -- removes all links in the current file that point to non-existent pages
      cleanup_links = "<leader>W<BS>",

      -- toggles the status of a GTD item
      -- [normal mode] works on the current line
      -- [visual mode] works on the selection
      toggle_task = "<leader>Wx",
      -- closes the floating window
      close_float = "q",
    },
  },
  keys = function()
    local neowiki = require("neowiki")
    return {
      { "<leader>W", "", desc = "wiki", mode = { "n", "v" } },
      { "<leader>Wb", neowiki.open_wiki, desc = "Open Wiki (buffer)" },
      { "<leader>Wf", neowiki.open_wiki_floating, desc = "Open Wiki (floating)" },
      { "<leader>Wt", neowiki.open_wiki_new_tab, desc = "Open Wiki (tab)" },
    }
  end,
}
