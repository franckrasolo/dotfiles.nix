return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  init = function()
    local Snacks = require("snacks")

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Set up lazy-loaded global members for debugging
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end,
    })
  end,
  opts = {
    bigfile = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    }
  },
  keys = function()
    local Snacks = require("snacks")

    return {
      { "<leader>un", desc = "Dismiss All Notifications", function() Snacks.notifier.hide() end },
      { "<leader>bd", desc = "Delete Buffer", function() Snacks.bufdelete() end },
      { "<leader>gg", desc = "Lazygit", function() Snacks.lazygit() end },
      { "<leader>gb", desc = "Git Blame Line", function() Snacks.git.blame_line() end },
      { "<leader>gB", desc = "Git Browse", function() Snacks.gitbrowse() end },
      { "<leader>gf", desc = "Lazygit Current File History", function() Snacks.lazygit.log_file() end },
      { "<leader>gl", desc = "Lazygit Log (cwd)", function() Snacks.lazygit.log() end },
      { "<leader>cR", desc = "Rename File", function() Snacks.rename() end },
      { "<c-/>",      desc = "Toggle Terminal", function() Snacks.terminal() end },
      { "<c-_>",      desc = "which_key_ignore", function() Snacks.terminal() end },
      { "]]",         desc = "Next Reference", function() Snacks.words.jump(vim.v.count1) end },
      { "[[",         desc = "Prev Reference", function() Snacks.words.jump(-vim.v.count1) end },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          }
        end,
      }
    }
  end
}
