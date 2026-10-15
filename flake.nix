{
  description = "macOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-lima = {
      url = "github:ciderale/nixos-lima";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    unf = {
      url = "git+https://git.atagen.co/atagen/unf";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    tree-sitter-lust = {
      url = "github:ArchangelJTW/lust-lang?dir=tree-sitter-lust";
      flake = false;
    };

    tree-sitter-pkl = {
      url = "github:apple/tree-sitter-pkl";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      platforms = [ "aarch64-darwin" ];

      overlay = final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          inherit (prev.stdenv.hostPlatform) system;
          config.allowBroken = true;
          config.allowUnfree = true;
          config.packageOverrides = prev: import ./pkgs { inherit (prev) pkgs; };
          config.permittedInsecurePackages = [
            "libxls-1.6.2"
          ];
        };

        # The upstream repo ships only grammar.js; the tree-sitter CLI needs the
        # generated src/ (grammar.json, parser.c) to load the language.
        tree-sitter-lust-repo = prev.stdenv.mkDerivation {
          pname = "tree-sitter-lust";
          version = "0.1.0";
          src = inputs.tree-sitter-lust;

          # `tree-sitter generate` runs grammar.js through node.
          nativeBuildInputs = [ prev.nodejs prev.tree-sitter ];

          dontConfigure = true;

          buildPhase = ''
            runHook preBuild
            export HOME=$TMPDIR
            tree-sitter generate
            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall
            mkdir -p $out
            cp -r . $out
            runHook postInstall
          '';
        };
        tree-sitter-pkl-repo = inputs.tree-sitter-pkl;
      };
      # makes "pkgs.unstable" available in configuration.nix
      overlayModule = ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; });

      user = rec {
        fullName = "Franck Rasolo";
        accountName = "franck.rasolo";
        homeDirectory = "/Users/${accountName}";
        dotfiles = "${homeDirectory}/dev/dotfiles.nix";
      };

      forAllSystems = f: nixpkgs.lib.genAttrs platforms (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      darwinConfigurations =
        let
          pkgs = nixpkgs.legacyPackages.aarch64-darwin;
          nixosModulesPath = "${inputs.nixpkgs-unstable}/nixos/modules";

          homeManagerExtraSpecialArgs = {
            inherit user;

            sops-nix-options = inputs.unf.lib.json {
              inherit self pkgs;
              modules = [ inputs.sops-nix.darwinModules.default ];
            };

            nixos-lima-options = inputs.unf.lib.json {
              inherit self pkgs;
              modules = with inputs.nixos-lima.nixosModules; [
                lima
                disk-default
                impure-config
              ];
              specialArgs = { inherit pkgs; modulesPath = nixosModulesPath; };
            };
          };
        in
        {
          m3max = inputs.nix-darwin.lib.darwinSystem {
            system  = "aarch64-darwin";
            inputs  = { inherit (inputs) nix-darwin nixpkgs; };
            modules = [
              { nix.extraOptions = ''extra-platforms = aarch64-darwin x86_64-darwin''; }
              overlayModule
              ./darwin/configuration.nix
              inputs.sops-nix.darwinModules.sops
              inputs.home-manager.darwinModules.home-manager {
                home-manager.extraSpecialArgs = homeManagerExtraSpecialArgs;
              }
            ];
            specialArgs = { inherit user; };
          };
        };

      checks = {
        aarch64-darwin.m3max = self.nix-darwin-configurations.m3max.system;
      };

      devShells = forAllSystems ({ pkgs }: with pkgs; {
        default = mkShell {
          shellHook = ''
            # health checks for Nix flake inputs
            nix run github:DeterminateSystems/flake-checker
          '';
        };
      });
    };
}
