return {
  "ivov/lisette",
  event = "VeryLazy",
  config = function(plugin)
    vim.opt.rtp:prepend(plugin.dir .. "/editors/nvim")
    dofile(plugin.dir .. "/editors/nvim/ftdetect/lisette.lua")
    dofile(plugin.dir .. "/editors/nvim/plugin/lisette.lua")
  end,
}
