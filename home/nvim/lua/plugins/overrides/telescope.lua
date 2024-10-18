return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    priority = 100,
    opts = function()
      local actions = require("telescope.actions")

      local function single_or_multi_select(prompt_bufnr)
        local current_picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        local multiple_selection = next(current_picker:get_multi_selection()) ~= nil

        if multiple_selection then
          local results = {}
          require("telescope.actions.utils").map_selections(
            prompt_bufnr,
            function(selection) table.insert(results, selection[1]) end
          )
          -- load selected files into buffers without switching to them
          for _, filepath in ipairs(results) do
            -- not the same as vim.fn.bufadd!
            vim.cmd.badd { args = { filepath } }
          end

          require("telescope.pickers").on_close_prompt(prompt_bufnr)

          -- if the active buffer is empty, switch to the frst newly loaded buffer
          if vim.fn.bufname() == "" and not vim.bo.modified then
            vim.cmd.bwipeout()
            vim.cmd.buffer(results[1])
          end
        else
          -- just edit the selected file
          actions.file_edit(prompt_bufnr)
        end
      end

      local function focus_preview(prompt_bufnr)
        local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
        vim.keymap.set(
          "n",
          "<Tab>",
          function() vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", picker.prompt_win)) end,
          { buffer = picker.previewer.state.bufnr }
        )
        vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", picker.previewer.state.winid))
      end

      local keybindings = {
        ["<c-l>"] = actions.smart_send_to_loclist + actions.open_loclist,
        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<cr>"] = single_or_multi_select,
        ["<c-bs>"] = actions.delete_buffer,

        ["π"] = require("telescope.actions.layout").toggle_preview, -- π -> <Alt-p>
        ["∏"] = focus_preview, -- ∏ -> <Alt-Shift-p>
      }
      return {
        defaults = {
          color_devicons = true,
          layout_strategy = "flex",
          layout_config = {
            horizontal = {
              preview_cutoff = 0,
              preview_width = 0.75,
            },
            vertical = {
              mirror = true,
              preview_cutoff = 25,
            },
            prompt_position = "top",
            width = 0.9,
            height = 0.8,
          },
          mappings = {
            i = keybindings,
            n = keybindings,
          },
          sorting_strategy = "ascending",
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("file_browser")
    end,
    opts = {
      extensions = {
        file_browser = {
          hidden = true,
          hijack_netrw = true,
        },
      },
    },
    keys = function()
      local file_browser = require("telescope").extensions.file_browser
      return {
        {
          "<leader>f<tab>",
          desc = "Telescope: Browse files (cwd)",
          -- open file_browser with the path of the current buffer
          function() file_browser.file_browser { path = "%:p:h", select_buffer = true } end,
          { silent = true, noremap = true },
        },
        {
          "<leader>f ",
          desc = "Telescope: Browse files (project dir)",
          function() file_browser.file_browser { path = vim.uv.cwd() } end,
          { silent = true, noremap = true },
        },
      }
    end,
  },
}
