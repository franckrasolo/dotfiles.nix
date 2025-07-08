local cache_dir = vim.fn.stdpath("cache") .. "/gitlab-ci-ls"

return {
  init_options = {
    cache = cache_dir,
    log_path = cache_dir .. "/log/gitlab-ci-ls.log",
    options = {
      dependencies_autocomplete_stage_filtering = false,
    },
  },
}
