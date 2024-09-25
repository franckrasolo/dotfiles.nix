{ pkgs, user, ... }:

{
  programs.direnv = with pkgs.unstable; {
    enable = true;
    enableZshIntegration = true;
    package = direnv;
    nix-direnv = {
      enable = true;
      package = nix-direnv;
    };
    config = {
      global = {
        disable_stdin = false;
        load_dotenv = true;
        strict_env = false;
        warn_timeout = "3s";
      };
      whitelist = {
        prefix = [
          "${user.homeDirectory}/dev/mojo"
          "${user.homeDirectory}/dev/Kotlin/fork-handles"
        ];
        exact = [
          "${user.homeDirectory}/dev/dotfiles.nix"
          "${user.homeDirectory}/dev/Rust/slice.rs"
        ];
      };
    };
    stdlib = builtins.readFile ./direnvrc;
  };
}
