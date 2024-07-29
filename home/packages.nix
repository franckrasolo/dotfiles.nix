{ pkgs, ... }:

with pkgs.unstable;
let
  securityTools = [
    _1password
    age
    gnupg
    openssl
    sops
  ];

  coreTools = [
    cachix
    coreutils
    devenv
    moreutils

    delta
    dos2unix
    dua
    eza
    fd
    fzf
    glow
#   gnused
    go-task
    gzip
    hyperfine
    just
    lsd
    pkgs.ripgrep
    pkgs.ripgrep-all
    sd
    skim
    slides
    stderred # legacyPackages.x86_64-darwin.stderred
    unrar
    unzip
    tree
    viu
    watch
    watchexec
    xz
    zellij
    zip
    zoxide
  ];

  systemTools = [
    bottom
    gdu
    htop
    fastfetch
    nushell
    pueue

    lf
    localsend
    socat
    vifm
    watchman
    xplr
    yazi
  ];

  gitTools = [
    git
    git-crypt
    diff-so-fancy
    lazygit
  ];

  httpTools = [
    aria2
    xh
  ];

  languageTools = [
    gettext
    grex
    rlwrap

    kotlin
    luajit
    luajitPackages.luarocks

    helix
    neovim
    neovim-remote
    tree-sitter
  ];

  pdfTools = [
    poppler
    zathura
  ];

  pythonTools = [
    basedpyright
    black
    pdm
    pur
    ruff

    python312
#    (python312.withPackages (pkgs: with pkgs; [ pip pynvim ]))
  ];

  dataTools = [
    python312Packages.demjson3
    fq
    ijq
    jnv
    jq
    yq-go
  ];

  graphicalTools = [
    graphviz
    plantuml
    timg
  ];
in
{
  home.packages = []
    ++ securityTools
    ++ coreTools
    ++ systemTools
    ++ gitTools
    ++ httpTools
    ++ languageTools
    ++ pdfTools
    ++ pythonTools
    ++ dataTools
    ++ graphicalTools
    ++ [ haxor-news ]
    ;
}
