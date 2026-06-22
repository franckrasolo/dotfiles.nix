{ pkgs, ... }:

with pkgs.unstable;
let
  securityTools = [
    _1password-cli
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
    pngpaste
    sd
    skim
    slides
    stderred
    unrar
    unzip
    tree
    util-linux
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

    snitch
    socat
    somo
    termshark
    watchman
  ];

  httpTools = [
    aria2
    xh
  ];

  languageTools = [
    ast-grep
    gettext
    grex
    rlwrap

    helix
    nixd
    nixfmt
    tokei
    tree-sitter
  ];

  pythonTools = [
    python314FreeThreading
    python314Packages.pip
#    (python314FreeThreading.withPackages (pkgs: with pkgs; [ pip pynvim ]))
  ];

  dataTools = [
    python313FreeThreading.pkgs.demjson3
    fq
    fx
    hl-log-viewer
    ijq
    jless
    jnv
    jq
    jqfmt
    mdq
    otree
    xan
    yq-go
    tabiew
  ];

  graphicalTools = [
    graphviz
    libwebp
    neo
    plantuml-c4
    termshot
    timg
  ];

  soundTools = [
    scdl
  ];
in
{
  home.packages = []
    ++ securityTools
    ++ coreTools
    ++ systemTools
    ++ httpTools
    ++ languageTools
    ++ pythonTools
    ++ dataTools
    ++ graphicalTools
    ++ [ haxor-news ]
    ++ soundTools
    ;
}
