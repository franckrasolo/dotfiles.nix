{ lua, pkgs }:

lua.pkgs.buildLuarocksPackage {
  pname = "luafun";
  version = "0.1.3-1";

  knownRockspec =
    (pkgs.fetchurl {
      url = "mirror://luarocks/fun-0.1.3-1.rockspec";
      sha256 = "03bimwzz9qwcs759ld69bljvnaim7dlsppg4w1hgxmvm6f2c8058";
    }).outPath;

  src = pkgs.fetchFromGitHub {
    owner = "luafun";
    repo = "luafun";
    rev = "12837884993a3d25bda8aaf835bb9d79132fcbc6";
    sha256 = "sha256-cSqdOiCKW32Xre2RWTeWl4gF5II2EZdEwVQaO2ydL18=";
  };

  disabled = lua.pkgs.luaOlder "5.1";
  propagatedBuildInputs = [ lua ];

  meta = {
    homepage = "https://github.com/luafun/luafun";
    description = "High-performance functional programming library for Lua";
    license.fullName = "MIT/X11";
  };
}
