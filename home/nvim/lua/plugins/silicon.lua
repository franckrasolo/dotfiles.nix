local screenshots_dir = "screenshots"

return {
  "michaelrommel/nvim-silicon",
  lazy = true,
  cmd = "Silicon",
  config = function(_, opts) require("nvim-silicon").setup(opts) end,
  opts = {
    disable_defaults = true,
    debug = false,
    no_line_number = true,

    language = function()
      return vim.bo.filetype
    end,

    output = function()
      return screenshots_dir .. os.date("!/%Y-%m-%dT%H-%M-%S") .. "_code.png"
    end,

    window_title = function()
      return vim.fs.basename(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
    end,
  },
  keys = {
    { mode = "v", "<leader>c;", desc = "Take a screenshot of the selected lines",
      function()
        if vim.fn.isdirectory(screenshots_dir) == 0 then
          vim.fn.mkdir(screenshots_dir, "p")
        end
        require("nvim-silicon").file()
      end,
    }
  },
}
