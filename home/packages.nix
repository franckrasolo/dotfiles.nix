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
    pkgs.stderred # legacyPackages.x86_64-darwin.stderred
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

    socat
    somo
    termshark
    watchman
  ];

  gitTools = [
    git
    git-crypt
    git-who
    diff-so-fancy
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

    kotlin
    (lua54Packages.lua.withPackages (ps:
      with ps; [
        lua
        luarocks
        luasocket
        moonscript
        penlight
      ]
    ))

    helix
    nixd
    nixfmt
    tokei
    tree-sitter
  ];

  pdfTools = [
    poppler
    zathura
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
    gobang
    hl-log-viewer
    ijq
    jless
    jnv
    jq
    mdq
    otree
    xan
    yq-go
    pkgs.tabiew
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
    ++ gitTools
    ++ httpTools
    ++ languageTools
    ++ pdfTools
    ++ pythonTools
    ++ dataTools
    ++ graphicalTools
    ++ [ haxor-news ]
    ++ soundTools
    ;
}
