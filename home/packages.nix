{ pkgs, ... }:

with pkgs.unstable;
let
  securityTools = [
    _1password
    age
    gnupg
    openssl
    sops
    teller
  ];

  coreTools = [
    cachix
    coreutils-prefixed
    devenv
    moreutils

    delta
    dos2unix
    dua
    dyff
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
    zip
  ];

  systemTools = [
    bottom
    gdu
    htop
    fastfetch
    nushell
    pueue

    socat
    termshark
    watchman
  ];

  gitTools = [
    git
    git-crypt
    diff-so-fancy
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
    lua54Packages.lua
    lua54Packages.luarocks

    helix
    nixd
    nixfmt-rfc-style
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

    python313FreeThreading
#    (python313FreeThreading.withPackages (pkgs: with pkgs; [ pip pynvim ]))
  ];

  dataTools = [
    python313FreeThreading.pkgs.demjson3
    fq
    fx
    ijq
    jnv
    jq
    yq-go
    tabiew
  ];

  graphicalTools = [
    graphviz
    libwebp
    neo
    plantuml-c4
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
