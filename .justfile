_targets:
  @just --list --unsorted --list-heading $'Available targets:\n' --list-prefix "  "

# applies the latest nix-darwin configuration
@switch:
  darwin-rebuild switch --flake . --fallback

# removes derivations from older nix-darwin generations
@gc:
  sudo nix-collect-garbage --delete-old

# updates the top-level flake lock file
@update:
  nix flake update
