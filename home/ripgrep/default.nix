{ pkgs, ... }:

with pkgs.unstable; {
  home.packages = [ ripgrep-all ];

  programs.ripgrep = {
    enable = true;
    package = ripgrep;
    arguments = [
      # search hidden files and directories
      "--hidden"

      # follow symbolic links
      "--follow"

      # exclude directories
      "--glob=!{.git,Trash,vendor,node_modules}"

      # Exclude file types
      "--glob=!*.{lock}"

      # exclude files
      "--glob=!{package-lock.json}"

      # do not print long lines, show a preview instead
      "--max-columns=150"
      "--max-columns-preview"

      # searches case insensitively
      "--smart-case"

      # sort by file path
      "--sort=path"

      # count the number of matches
      #--count

      # always show line numbers for matches
      "--line-number"

      # show the surrounding context
      #"--context=3"

      "--color=auto"
      "--multiline"
      "--type-add=web:*.{htm,html,css,sass,scss,js,jsx,ts}*"

      # color settings and styles
      "--colors=path:fg:blue"
      "--colors=path:style:bold"
      "--colors=line:fg:green"
      "--colors=line:style:bold"
      "--colors=match:fg:red"
      "--colors=match:style:bold"

      # suppress all error messages related to opening and reading files
      "--no-messages"
    ];
  };

  xdg.configFile."ripgrep/.rgignore".source = ./.rgignore;
}
