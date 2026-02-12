return {
  {
    "lewis6991/gitsigns.nvim",
    version = "*",
    opts = function(_, opts)
      opts.current_line_blame = true
      opts.current_line_blame_formatter =
        "<abbrev_sha> — <author_time:%a %d/%m/%Y %H:%M:%S> — <author>: <summary>  "
      opts.current_line_blame_opts = {
        delay = 0,
        ignore_whitespace = true,
        virt_text_pos = "right_align",
      }

      vim.api.nvim_set_hl(0, "DiffText", { bg = "#2A3554", fg = "#C1E0FF" })
      vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#6C738C", italic = true })

      vim.api.nvim_set_hl(0, "GitSignsAddInline", { bg = "#0E2E21" })
      vim.api.nvim_set_hl(0, "GitSignsChangeInline", { bg = "#2A3554" })
      vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { bg = "#471613" })

      vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight", { bg = "#0F0F1C" })

      local default_on_attach = opts.on_attach
      opts.on_attach = function(buffer)
        default_on_attach(buffer)

        local function map(mode, l, desc, r)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc, silent = true, noremap = true })
        end

        local function nav_hunk(direction)
          local gitsigns = package.loaded.gitsigns

          gitsigns.nav_hunk(direction, {
            navigation_message = false,
            foldopen = true,
            greedy = true,
            preview = false,
            target = "all",
            wrap = true,
          })

          vim.schedule(function()
            gitsigns.preview_hunk_inline()
            vim.fn.feedkeys("zz", "n")
          end)
        end

        map("n", "]h", "Next Hunk", function()
          if vim.wo.diff then
            vim.cmd.normal { "]c", bang = true }
          else
            nav_hunk("next")
          end
        end)

        map("n", "[h", "Prev Hunk", function()
          if vim.wo.diff then
            vim.cmd.normal { "[c", bang = true }
          else
            nav_hunk("prev")
          end
        end)

        map("n", "]H", "Last Hunk", function() nav_hunk("last") end)
        map("n", "[H", "First Hunk", function() nav_hunk("first") end)

        vim.keymap.del("n", "<leader>ghd", { buffer = buffer })
        vim.keymap.del("n", "<leader>ghD", { buffer = buffer })
      end
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    opts = {
      kind = "vsplit",
      graph_style = "unicode",
      signs = {
        section = { "", "" },
        item = { "", "" },
        hunk = { "󰡍", "󰡏" },
      },
      filewatcher = {
        interval = 1000,
        enabled = true,
      },
      integrations = { diffview = true },
      sections = {
        untracked = { folded = true },
      },
      commit_editor = {
        kind = "floating",
      },
      mappings = {
        status = {
          ["[h"] = "GoToPreviousHunkHeader",
          ["]h"] = "GoToNextHunkHeader",
        },
      },
    },
    keys = function()
      local neogit = require("neogit")
      return {
        { "<leader>gF", desc = "Fetch", function() neogit.action("fetch", "fetch_pushremote")() end },
        { "<leader>gp", desc = "Pull", function() neogit.action("pull", "from_pushremote")() end },
        { "<leader>gP", desc = "Push", function() neogit.action("push", "to_pushremote")() end },
        { "<leader>gs", desc = "Status", "<cmd>Neogit cwd=%:p:h<cr>" },
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { -- config for changed files and staged files in diff views
          layout = "diff2_vertical",
          disable_diagnostics = false,
          winbar_info = true,
        },
        file_history = {
          layout = "diff2_vertical",
          disable_diagnostics = false,
          winbar_info = true,
        },
      },
    },
  },
  {
    "tanvirtin/vgit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    -- lazy loading on 'VimEnter' event is necessary
    event = "VimEnter",
    config = function()
      local vgit = require("vgit")

      vgit.setup {
        keymaps = {
          {
            mode = "n",
            key = "<leader>gd",
            handler = vgit.buffer_diff_preview,
            desc = "Diff Buffer",
          },
          {
            mode = "n",
            key = "<leader>gu",
            handler = vgit.buffer_reset,
            desc = "Reset Buffer",
          },
          {
            mode = "n",
            key = "<leader>gD",
            handler = vgit.project_diff_preview,
            desc = "Diff Repo Preview",
          },
          {
            mode = "n",
            key = "<leader>gx",
            handler = vgit.toggle_diff_preference,
            desc = "Toggle Split/Unified Diff",
          },
        },
        settings = {
          -- either allow corresponding mapping for existing highlight groups or redefine them entirely
          hls = {
            GitCount = "Keyword",
            GitSymbol = "CursorLineNr",
            GitTitle = "Directory",
            GitSelected = "QuickfixLine",
            GitBackground = "Normal",
            GitAppBar = "StatusLine",
            GitHeader = "NormalFloat",
            GitFooter = "NormalFloat",
            GitBorder = "LineNr",
            GitLineNr = "LineNr",
            GitComment = "Comment",
            GitSignsAdd = {
              gui = nil,
              fg = "#D7FFAF",
              bg = nil,
              sp = nil,
              override = false,
            },
            GitSignsChange = {
              gui = nil,
              fg = "#7AA6DA",
              bg = nil,
              sp = nil,
              override = false,
            },
            GitSignsDelete = {
              gui = nil,
              fg = "#E95678",
              bg = nil,
              sp = nil,
              override = false,
            },
            GitSignsAddLn = "DiffAdd",
            GitSignsDeleteLn = "DiffDelete",
            GitWordAdd = {
              gui = nil,
              fg = nil,
              bg = "#5D7A22",
              sp = nil,
              override = false,
            },
            GitWordDelete = {
              gui = nil,
              fg = nil,
              bg = "#960F3D",
              sp = nil,
              override = false,
            },
            GitConflictCurrentMark = "DiffAdd",
            GitConflictAncestorMark = "Visual",
            GitConflictIncomingMark = "DiffChange",
            GitConflictCurrent = "DiffAdd",
            GitConflictAncestor = "Visual",
            GitConflictMiddle = "Visual",
            GitConflictIncoming = "DiffChange",
          },
          live_blame = {
            enabled = true,
            format = function(blame, git_config)
              local config_author = git_config["user.name"]
              local author = blame.author
              if config_author == author then author = "You" end
              local time = os.difftime(os.time(), blame.author_time) / (60 * 60 * 24 * 30 * 12)
              local time_divisions = {
                { 1, "years" },
                { 12, "months" },
                { 30, "days" },
                { 24, "hours" },
                { 60, "minutes" },
                { 60, "seconds" },
              }
              local counter = 1
              local time_division = time_divisions[counter]
              local time_boundary = time_division[1]
              local time_postfix = time_division[2]
              while time < 1 and counter ~= #time_divisions do
                time_division = time_divisions[counter]
                time_boundary = time_division[1]
                time_postfix = time_division[2]
                time = time * time_boundary
                counter = counter + 1
              end
              local commit_message = blame.commit_message
              if not blame.committed then
                author = "You"
                commit_message = "Uncommitted changes"
                return string.format(" %s • %s", author, commit_message)
              end
              local max_commit_message_length = 255
              if #commit_message > max_commit_message_length then
                commit_message = commit_message:sub(1, max_commit_message_length) .. "..."
              end
              return string.format(
                " %s, %s • %s",
                author,
                string.format("%s %s ago", time >= 0 and math.floor(time + 0.5) or math.ceil(time - 0.5), time_postfix),
                commit_message
              )
            end,
          },
          live_gutter = {
            enabled = true,
            edge_navigation = true, -- This allows users to navigate within a hunk
          },
          scene = {
            diff_preference = "unified", -- unified or split
            keymaps = {
              quit = "q",
            },
          },
          diff_preview = {
            keymaps = {
              reset = "r",
              buffer_stage = "S",
              buffer_unstage = "U",
              buffer_hunk_stage = "s",
              buffer_hunk_unstage = "u",
              toggle_view = "t",
            },
          },
          project_diff_preview = {
            keymaps = {
              commit = "C",
              buffer_stage = "s",
              buffer_unstage = "u",
              buffer_hunk_stage = "gs",
              buffer_hunk_unstage = "gu",
              buffer_reset = "r",
              stage_all = "S",
              unstage_all = "U",
              reset_all = "R",
            },
          },
          project_stash_preview = {
            keymaps = {
              add = "A",
              apply = "a",
              pop = "p",
              drop = "d",
              clear = "C",
            },
          },
          project_logs_preview = {
            keymaps = {
              previous = "-",
              next = "=",
            },
          },
          project_commit_preview = {
            keymaps = {
              save = "S",
            },
          },
          signs = {
            priority = 10,
            definitions = {
              -- The sign definitions you provide will automatically be instantiated for you.
              GitConflictCurrentMark = {
                linehl = "GitConflictCurrentMark",
                texthl = nil,
                numhl = nil,
                icon = nil,
                text = "",
              },
              GitConflictAncestorMark = {
                linehl = "GitConflictAncestorMark",
                texthl = nil,
                numhl = nil,
                icon = nil,
                text = "",
              },
              GitConflictIncomingMark = {
                linehl = "GitConflictIncomingMark",
                texthl = nil,
                numhl = nil,
                icon = nil,
                text = "",
              },
              GitConflictCurrent = {
                linehl = "GitConflictCurrent",
                texthl = nil,
                numhl = nil,
                icon = nil,
                text = "",
              },
              GitConflictAncestor = {
                linehl = "GitConflictAncestor",
                texthl = nil,
                numhl = nil,
                icon = nil,
                text = "",
              },
              GitConflictMiddle = {
                linehl = "GitConflictMiddle",
                texthl = nil,
                numhl = nil,
                icon = nil,
                text = "",
              },
              GitConflictIncoming = {
                linehl = "GitConflictIncoming",
                texthl = nil,
                numhl = nil,
                icon = nil,
                text = "",
              },
              GitSignsAddLn = {
                linehl = "GitSignsAddLn",
                texthl = nil,
                numhl = nil,
                icon = nil,
                text = "",
              },
              GitSignsDeleteLn = {
                linehl = "GitSignsDeleteLn",
                texthl = nil,
                numhl = nil,
                icon = nil,
                text = "",
              },
              GitSignsAdd = {
                texthl = "GitSignsAdd",
                numhl = nil,
                icon = nil,
                linehl = nil,
                text = "┃",
              },
              GitSignsDelete = {
                texthl = "GitSignsDelete",
                numhl = nil,
                icon = nil,
                linehl = nil,
                text = "┃",
              },
              GitSignsChange = {
                texthl = "GitSignsChange",
                numhl = nil,
                icon = nil,
                linehl = nil,
                text = "┃",
              },
            },
            usage = {
              -- Please ensure these signs are defined.
              screen = {
                add = "GitSignsAddLn",
                remove = "GitSignsDeleteLn",
                conflict_current_mark = "GitConflictCurrentMark",
                conflict_current = "GitConflictCurrent",
                conflict_middle = "GitConflictMiddle",
                conflict_incoming_mark = "GitConflictIncomingMark",
                conflict_incoming = "GitConflictIncoming",
                conflict_ancestor_mark = "GitConflictAncestorMark",
                conflict_ancestor = "GitConflictAncestor",
              },
              main = {
                add = "GitSignsAdd",
                remove = "GitSignsDelete",
                change = "GitSignsChange",
              },
            },
          },
          symbols = {
            void = "⣿",
            open = "",
            close = "",
          },
        },
      }
    end,
  },
}
