return {
  { "folke/persistence.nvim", enabled = false },
  {
    "olimorris/persisted.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    event = "BufReadPre",
    lazy = false,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "PersistedTelescopeLoadPre",
        callback = function(session)
          -- save the currently loaded session passing in the path to the current session
          require("persisted").save { session = vim.g.persisted_loaded_session }

          -- delete all open buffers
          vim.api.nvim_input("<esc>:%bd!<cr>")
        end,
      })
    end,
    config = function(_, opts)
      require("persisted").setup(opts)
      require("telescope").load_extension("persisted")
    end,
    opts = function()
      vim.o.sessionoptions = "buffers,curdir,folds,globals,tabpages,winpos,winsize"

      return {
        autostart = true, -- automatically start this plugin on Neovim startup

        should_save = function()
          if vim.bo.filetype == "alpha" then return false end -- do not save the alpha dashboard
          if vim.bo.filetype == "" and vim.api.nvim_buf_get_name(0) == "" then return false end
          if vim.api.nvim_buf_get_name(0):match("COMMIT_EDITMSG") then return false end
          return true
        end,

        save_dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),

        follow_cwd = true,     -- change the session file to match any change in the cwd
        use_git_branch = true, -- include the git branch in the session file name
        autoload = false,      -- do not automatically load the session for the cwd on Neovim startup

        -- what to do when there is no session to automatically load
        on_autoload_no_session = function() vim.notify("No existing session to load") end,

        allowed_dirs = { -- root directories for starting and autloading sessions
          "~/dev",
        },

        ignored_dirs = { -- root directories to ignore when starting and autloading sessions
          { "~", exact = true },
          "~/.xdg",
          "~/Desktop",
          "~/Documents",
          "~/Downloads",
          "~/Library",

          { "/", exact = true },
          "/nix/store",
          "/tmp",
        },
      }
    end,
    keys = function()
      return {
        { "<leader>qm", desc = "Manage sessions", require("telescope").extensions.persisted.persisted },
        { "<leader>qq", desc = "Quit session", function() require("persisted").save(); vim.cmd("wqa") end },
      }
    end,
  },
  {
    "goolord/alpha-nvim",
    opts = function(_, dashboard)
      local button = dashboard.button("s", "  Restore Session", require("persisted").load)
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
      dashboard.section.buttons.val[6] = button
    end,
  },
}
