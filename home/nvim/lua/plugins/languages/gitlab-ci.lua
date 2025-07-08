return {
  vim.filetype.add {
    pattern = {
      [".*%.gitlab%-ci%.ya?ml"] = "yaml.gitlab",
      [".*/%.gitlab/.*%.ya?ml"] = "yaml.gitlab",
      [".*/c[id][:/].*%.ya?ml"] = "yaml.gitlab",
    },
  },

  vim.lsp.enable { "yamlls", "gitlab_ci_ls" },
}
