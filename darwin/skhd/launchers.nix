{ ... }:

''
fn - k : open -n -a /Applications/kitty.app --args --directory ~/dev/dotfiles.nix --single-instance
fn - y : open -n -a /Applications/Alacritty.app --args --config-file ~/.xdg/config/alacritty/alacritty.yml
fn - w : open -n -a ~/Library/Homebrew/Applications/WezTerm.app
fn - 1 : open -a /Applications/1Password.app
fn - a : open -a /Applications/Alfred\ 5.app
fn - c : sops -d ~/dev/dotfiles.nix/secrets/bootstrap.yaml | sed -n 1p | sed -E 's/opmk: //' | tr -d '\n' | pbcopy
fn - f : sops -d ~/dev/dotfiles.nix/secrets/bootstrap.yaml | sed -n 3p | sed -E 's/s2p2: //' | tr -d '\n' | pbcopy
fn - l : printf "" | pbcopy
fn - g : ~/.xdg/local/bin/goland
fn - i : ~/.xdg/local/bin/idea
fn - p : open -a /System/Applications/System\ Preferences.app
fn - z : open -a /Applications/zoom.us.app
''
