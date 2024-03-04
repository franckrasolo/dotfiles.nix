{ ... }:

''
lcmd + lshift - y : open -n -a /Applications/Alacritty.app --args --config-file ~/.xdg/config/alacritty/alacritty.toml
lcmd + lshift - w : open -n -a /opt/homebrew/bin/wezterm
lcmd + lshift - 1 : open -a /Applications/1Password.app
lcmd + lshift - a : open -a /Applications/Alfred\ 5.app
lcmd + lshift - c : sops -d ~/dev/dotfiles.nix/secrets/bootstrap.yaml | sed -n 1p | sed -E 's/opmk: //' | tr -d '\n' | pbcopy
lcmd + lshift - f : sops -d ~/dev/dotfiles.nix/secrets/bootstrap.yaml | sed -n 3p | sed -E 's/s2p2: //' | tr -d '\n' | pbcopy
lcmd + lshift - d : printf "" | pbcopy
lcmd + lshift - g : ~/.xdg/local/bin/goland
lcmd + lshift - i : ~/.xdg/local/bin/idea
lcmd + lshift - s : open -a /System/Applications/System\ Settings.app
lcmd + lshift - z : open -a /Applications/zoom.us.app
''
