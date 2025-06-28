---@type vim.lsp.Config
return {
  root_markers = {
    ".git",
    ".venv",
    "uv.lock",
  },
  settings = {
    basedpyright = {
      disableOrganizeImports = false,
      verboseOutput = true,

      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,

        inlayHints = {
          -- callArgumentNames = true,
          functionReturnTypes = true,
          genericTypes = true,
          variableTypes = true,
        },
      },
    },
  },
}
