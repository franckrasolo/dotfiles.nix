---@type vim.lsp.Config
return {
  root_markers = {
    ".venv",
    "uv.lock",
  },
  settings = {
    basedpyright = {
      disableOrganizeImports = false,
      verboseOutput = true,

      analysis = {
        autoImportCompletions = false,
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        disableTaggedHints = false,
        useLibraryCodeForTypes = true,

        inlayHints = {
          callArgumentNames = true,
          functionReturnTypes = true,
          genericTypes = true,
          variableTypes = true,
        },
      },
    },
  },
}
