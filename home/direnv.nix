{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    config = {
      global = {
        disable_stdin = false;
        load_dotenv = true;
        strict_env = false;
        warn_timeout = "3s";
      };
    };
  };
}
