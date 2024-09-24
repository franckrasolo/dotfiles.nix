return {
  {
    "lewis6991/gitsigns.nvim",
    opts = function(_, opts)
      opts.current_line_blame = true
      opts.current_line_blame_formatter = "<abbrev_sha> — <author_time:%a %d/%m/%Y %H:%M:%S> — <author>: <summary>  "
      opts.current_line_blame_opts = {
        delay = 0,
        ignore_whitespace = true,
        virt_text_pos = "right_align"
      }

      local function highlight(group, attributes)
        vim.api.nvim_set_hl(0, group, attributes)
      end

      highlight("DiffAdd", { bg = "#0E2E21" })
      highlight("DiffChange", { bg = "#1A345A" })
      highlight("DiffDelete", { bg = "#471613" })
      highlight("DiffText", { bg = "#D4CF94", fg = "#1A345A", bold = true, italic = true })

      highlight("GitSignsAddLn", { bg = "#0E2E21" })
      highlight("GitSignsAddPreview", { bg = "#0E2E21" })
      highlight("GitSignsDeletePreview", { bg = "#471613" })
      highlight("GitSignsCurrentLineBlame", { fg = "#6C738C", italic = true })

      highlight("GitSignsAddInline", { bg = "#D4CF94", fg = "#0E2E21", bold = true, italic = true })
      highlight("GitSignsChangeInline", { bg = "#D4CF94", fg = "#0E2E21", bold = true, italic = true })
      highlight("GitSignsDeleteInline", { bg = "#D4CF94", fg = "#471613", bold = true, italic = true })

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
            vim.cmd.normal({ "]c", bang = true })
          else
            nav_hunk("next")
          end
        end)

        map("n", "[h", "Prev Hunk", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            nav_hunk("prev")
          end
        end)

        map("n", "]H", "Last Hunk", function() nav_hunk("last") end)
        map("n", "[H", "First Hunk", function() nav_hunk("first") end)

        vim.keymap.del("n", "<leader>ghd", { buffer = buffer })
        vim.keymap.del("n", "<leader>ghD", { buffer = buffer })
      end
    end
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
        { "<leader>gf", desc = "Fetch", function() neogit.action("fetch", "fetch_pushremote")() end },
        { "<leader>gp", desc = "Pull", function() neogit.action("pull", "from_pushremote")() end },
        { "<leader>gP", desc = "Push", function() neogit.action("push", "to_pushremote")() end },
        { "<leader>gs", desc = "Status", "<cmd>Neogit cwd=%:p:h<cr>" },
        {
          "<leader>gd", desc = "File Diff",
          function()
            local diffview = require("neogit.integrations.diffview")
            diffview.open("blank", vim.fn.expand("%"), { only = true })
          end,
        },
        {
          "<leader>gH", desc = "File History",
          function()
            neogit.action("log", "log_current", { "--", vim.fn.expand("%") })()
          end,
        },
        {
          "<leader>gv", desc = "Selection History",
          function()
            local file = vim.fn.expand("%")
            vim.cmd([[execute "normal! \<ESC>"]])
            local line_start = vim.fn.getpos("'<")[2]
            local line_end = vim.fn.getpos("'>")[2]
            neogit.action("log", "log_current", { "-L" .. line_start .. "," .. line_end .. ":" .. file })()
          end,
          mode = "v",
        },
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
}
