{ config, pkgs, user, ... }:

with pkgs.unstable; {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = neovim-unwrapped;

    extraLuaPackages = ps: with ps; [
      magick
    ];

    extraPackages = [
      imagemagick
      nodejs_20
    ];
  };

#  xdg.configFile."nvim".source = ./.;
  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "${user.homeDirectory}/dev/dotfiles.nix/home/nvim";

  home.packages = [
    neovim-remote
  ];

  home.sessionVariables = {
    PAGER  = "less -FR";
    EDITOR = "nvim";
    VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'";
    TERM   = "xterm-256color";
  };
}
