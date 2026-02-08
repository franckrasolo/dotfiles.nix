---@type vim.lsp.Config
return {
  root_markers = {
    ".venv",
    "uv.lock",
  },
  capabilities = {
    offsetEncoding = { "utf-16" },
    general = {
      positionEncodings = { "utf-16" },
    },
  },
  offset_encoding = "utf-16",
}
