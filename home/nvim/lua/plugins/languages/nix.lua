return {
  "neovim/nvim-lspconfig",
  config = function()
    local flake_dir = "~/dev/dotfiles.nix"

    require("lspconfig").nixd.setup {
      cmd = { "nixd" },
      settings = {
        nixd = {
          nixpkgs = {
            expr = "import <nixpkgs> {}",
          },
          options = {
            nix_darwin = {
              expr = string.format(
                "(builtins.getFlake \"%s\").darwinConfigurations.%s.options",
                flake_dir,
                vim.uv.os_gethostname()
              ),
            },
          },
        },
      },
    }
  end,
}
