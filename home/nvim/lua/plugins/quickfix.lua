return {
  "kevinhwang91/nvim-bqf",
  ft = "qf",
  event = "VeryLazy",
  dependencies = {
    "ibhagwan/fzf-lua",
    { "junegunn/fzf", name = "fzf", build = "./install --bin" },
  },
}