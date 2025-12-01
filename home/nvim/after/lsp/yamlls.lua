---@type vim.lsp.Config
return {
  capabilities = {
    textDocument = {
      -- advertise Neovim's support for line folding
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
  settings = {
    -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
    redhat = { telemetry = { enabled = false } },

    yaml = {
      completion = true,
      format = { enable = true },
      hover = true,
      keyOrdering = false,
      validate = true,

      customTags = {
        -- https://docs.gitlab.com/ci/yaml/yaml_optimization/#reference-tags
        -- https://docs.gitlab.com/ci/yaml/yaml_optimization/#configure-your-ide-to-support-reference-tags
        "!reference sequence",
      },

      schemaDownload = { enable = true },
      schemaStore = {
        -- use schemas from the SchemaStore.nvim plugin instead
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas {
        extra = {
          {
            name = "gitlab-ci",
            description = "GitLab CI schema",
            url = "https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json",
            fileMatch = {
              "**/*.gitlab-ci.{yaml,yml}",
              "**/.gitlab/**/*.{yaml,yml}",
              "**/{ci,cd}/**/*.{yaml,yml}",
              "**/pipeline.{yaml,yml}",
            },
          },
          {
            name = "kubernetes",
            description = "Kubernetes schema",
            url = "https://github.com/yannh/kubernetes-json-schema/raw/refs/heads/master/v1.34.2-standalone-strict/all.json",
            fileMatch = {
              "**/*.k8s.{yaml,yml}",
              "**/k8s/**/*.{yaml,yml}",
            },
          },
          {
            name = "popeye",
            description = "Popeye configuration schema",
            url = "https://github.com/derailed/popeye/raw/refs/heads/master/pkg/config/json/schemas/spinach.json",
            fileMatch = {
              "**/popeye.yaml",
              "**/spinach.yaml",
            }
          },
        },
      },
    },
  },
}
