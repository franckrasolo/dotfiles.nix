{ pkgs, ... }:

{
  home.packages = with pkgs.unstable; [ tree-sitter ];

  xdg.configFile."tree-sitter/config.json".source = ./config.json;
  xdg.dataFile."tree-sitter/grammars/tree-sitter-pkl".source = pkgs.tree-sitter-pkl-repo;
  xdg.dataFile."tree-sitter/queries".source = ./queries;
}
