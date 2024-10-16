return {
  "Vigemus/iron.nvim",
  event = "VeryLazy",
  main = "iron.core",
  opts = function()
    return {
      config = {
        -- discard any REPL after use
        scratch_repl = true,
        repl_definition = {
          sh = { command = "zsh" },
          lua = { command = "lua" },
          nix = { command = { "nix", "repl", vim.uv.cwd() } },
          python = {
            command = { "python3" },
            format = require("iron.fts.common").bracketed_paste_python
          },
          mojo = { command = { "magic", "run", "mojo" } },
          haskell = {
            command = function(meta)
              local file = vim.api.nvim_buf_get_name(meta.current_bufnr)
              -- call `require` in case iron is set up before haskell-tools
              return require("haskell-tools").repl.mk_repl_cmd(file)
            end,
          },
        },
        repl_open_cmd = require("iron.view").split.vertical.botright(0.4),
      },
      highlight = {
        bold = false,
        italic = true,
      },
      ignore_blank_lines = true, -- when sending selected lines
    }
  end,
  keys = function()
    local iron = require("iron.core")
    local marks = require("iron.marks")

    return {
      { "g<cr>", desc = "REPL", mode = { "n", "v" }, "" },

      { "g<cr>o", desc = "Open REPL",  mode = { "n", "v" }, vim.cmd.IronRepl },
      { "g<cr>f", desc = "Focus REPL", mode = { "n", "v" }, vim.cmd.IronFocus },
      { "g<cr>h", desc = "Hide REPL",  mode = { "n", "v" }, vim.cmd.IronHide },
      { "g<cr>r", desc = "Restart REPL", mode = { "n", "v" }, vim.cmd.IronRestart },

      { "g<cr>D", desc = "Clear REPL", mode = { "n", "v" }, function() iron.send(nil, string.char(12)) end },
      { "g<cr>q", desc = "Close REPL", mode = { "n", "v" }, function() iron.close_repl() end },
      { "g<cr><esc>", desc = "Interrupt REPL", mode = { "n", "v" }, function() iron.send(nil, string.char(03)) end },

      { "g<cr><cr>", desc = "Enter", mode = { "n", "v" }, function() iron.send(nil, string.char(13)) end },
      { "g<cr>k", desc = "Run this buffer", mode = { "n", "v" }, "<cmd>source %<cr>" },

      { "g<cr>s",  desc = "send", mode = { "n", "v" }, "" },
      { "g<cr>ss", desc = "Send motion", function() iron.run_motion("send_motion") end },
      { "g<cr>sv", desc = "Send selection", mode = "v", function() iron.visual_send() end },
      { "g<cr>sm", desc = "Send mark", function() iron.send_mark() end },
      { "g<cr>st", desc = "Send until cursor", function() iron.send_until_cursor() end },
      { "g<cr>sl", desc = "Send line", function() iron.send_line() end },
      { "g<cr>sp", desc = "Send paragraph", function() iron.send_paragraph() end },
      { "g<cr>sf", desc = "Send file", function() iron.send_file() end },


      { "g<cr>m",  desc = "mark", mode = { "n", "v" }, "" },
      { "g<cr>mm", desc = "Mark motion", function() iron.run_motion("mark_motion") end },
      { "g<cr>mv", desc = "Mark selection", mode = "v", function() iron.mark_visual() end },
      { "g<cr>mx", desc = "Remove mark", function() marks.drop_last() end },
      { "g<cr>m<esc>", desc = "Clear highlight", mode = "v", function() marks.clear_hl() end },
    }
  end,
}
