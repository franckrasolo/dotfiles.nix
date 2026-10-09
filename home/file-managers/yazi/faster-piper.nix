{ pkgs, lib, ... }:

pkgs.yaziPlugins.mkYaziPlugin {
  pname = "faster-piper.yazi";
  version = "1.1.1";

  src = pkgs.fetchFromGitHub {
    owner = "alberti42";
    repo = "faster-piper.yazi";
    rev = "bb90261ce3952762b0de2d5720ea176615c1bbd9";
    hash = "sha256-a7/KTIoIU9idxhYmYFsp6/ezmiBK/mEYfEz9zqZZiEU=";
  };

  meta = {
    description = "A fast, cache-aware reimplementation of piper.yazi for Yazi.";
    homepage = "https://github.com/alberti42/faster-piper.yazi";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
