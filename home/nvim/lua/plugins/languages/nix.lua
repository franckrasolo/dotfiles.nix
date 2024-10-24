return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    local flake_dir = "~/dev/dotfiles.nix"
    local flake_expr = "(builtins.getFlake \"" .. flake_dir .. "\")"
    local hostname = vim.uv.os_gethostname()
    local nix_darwin_options = flake_expr .. ".darwinConfigurations." .. hostname .. ".options"

    opts.servers.nixd = {
      cmd = { "nixd" },
      settings = {
        nixd = {
          nixpkgs = {
            expr = "import " .. flake_expr .. ".inputs.nixpkgs {}",
          },
          options = {
            nix_darwin = {
              expr = nix_darwin_options,
            },
          },
        },
      },
    }
  end,
}
