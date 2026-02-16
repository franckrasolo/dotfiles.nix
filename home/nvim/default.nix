{ config, pkgs, user, ... }:

with pkgs.unstable; {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = neovim-unwrapped;

    extraLuaPackages = ps: with ps; [
      magick
      penlight
    ];

    extraPackages = [
      imagemagick
      nodejs_20

      gitlab-ci-ls
      yaml-language-server
    ];
  };

#  xdg.configFile."nvim".source = ./.;
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${user.dotfiles}/home/nvim";

  home.packages = [
    neovim-remote
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    PAGER  = "less -FR";
    TERM   = "xterm-256color";
  };
}
