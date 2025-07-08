{ config, pkgs, user, ... }:

with pkgs.unstable; {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    package = neovim-unwrapped // {
      meta = {
        description = "Vim text editor fork focused on extensibility and agility";
        license = with lib.licenses; [ asl20 vim ];
        maintainers = with lib.maintainers; [ manveru rvolosatovs ];
        platforms = lib.platforms.unix;
      };
    };

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
