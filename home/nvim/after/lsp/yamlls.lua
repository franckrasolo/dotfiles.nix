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
            name = "docker-compose",
            description = "docker-compose YAML schema",
            url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
            fileMatch = {
              "**/compose.{yaml,yml}",
              "**/compose.*.{yaml,yml}",
              "**/docker-compose.{yaml,yml}",
              "**/docker-compose.*.{yaml,yml}",
            },
          },
          {
            name = "github-action",
            description = "github-action YAML schema",
            url = "https://www.schemastore.org/github-workflow.json",
            fileMatch = {
              "*/.github/workflows/*.{yaml,yml}",
              "**/.gitea/workflows/*.{yaml,yml}",
              "**/.forgejo/workflows/*.{yaml,yml}",
            },
          },
          {
            name = "gitlab-ci",
            description = "gitlab-ci YAML schema",
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
            description = "Kubernetes YAML schema",
            url = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/v1.33.2-standalone-strict/all.json",
            fileMatch = {
              "**/*.k8s.{yaml,yml}",
              "**/k8s/*.{yaml,yml}",
            },
          },
          {
            name = "graphql",
            description = "GraphQL YAML schema",
            url = "https://unpkg.com/graphql-config/config-schema.json",
            fileMatch = {
              "graphql.config.{yaml,yml}",
              ".graphqlrc",
              ".graphqlrc.{yaml,yml}",
            },
          },
          {
            name = "pre-commit configuration",
            description = "pre-commit configuration YAML schema",
            url = "https://www.schemastore.org/pre-commit-config.json",
            fileMatch = {
              ".pre-commit-config.{yaml,yml}",
            },
          },
          {
            name = "pre-commit hooks",
            description = "pre-commit hooks YAML schema",
            url = "https://www.schemastore.org/pre-commit-hooks.json",
            fileMatch = {
              ".pre-commit-hooks.{yaml,yml}",
            },
          },
        },
      },
    },
  },
}
