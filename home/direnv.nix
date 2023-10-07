{ user, ... }:

{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        disable_stdin = false;
        load_dotenv = true;
        strict_env = true;
        warn_timeout = "3s";
      };
      whitelist = {
        exact = [
          "${user.homeDirectory}/dev/dotfiles.nix"
          "${user.homeDirectory}/dev/Rust/slice.rs"
        ];
      };
    };
    stdlib = ''
    # adapted from https://github.com/direnv/direnv/issues/73#issuecomment-1192448475

    export_alias() {
      local name=$1
      shift
      local alias_dir=$PWD/.direnv/aliases
      local target="$alias_dir/$name"
      local oldpath="$PATH"

      mkdir -p "$alias_dir"
      if ! [[ ":$PATH:" == *":$alias_dir:"* ]]; then
        PATH_add "$alias_dir"
      fi

      cat << EOF > "$target"
    #!/usr/bin/env bash
    PATH="$oldpath"

    $@
    EOF
      chmod +x "$target"
    }
    '';
  };
}
