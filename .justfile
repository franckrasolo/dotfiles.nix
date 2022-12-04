_targets:
  @just --list --unsorted --list-heading $'Available targets:\n' --list-prefix "  "

# applies the latest nix-darwin configuration
@switch:
  darwin-rebuild switch --flake . --fallback

# removes obsolete artifacts from older nix-darwin configurations
@gc:
  sudo nix-collect-garbage --delete-old

# updates the top-level flake lock file
@update:
  nix flake update
