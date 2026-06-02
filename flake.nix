{
  description = "macOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    unf = {
      url = "git+https://git.atagen.co/atagen/unf";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    zsh-patina = {
      url = "github:michel-kraemer/zsh-patina";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
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

        zsh-patina = inputs.zsh-patina.packages.${prev.stdenv.hostPlatform.system}.default;
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

          homeManagerExtraSpecialArgs = {
            inherit user;

            sops-nix-options = inputs.unf.lib.json {
              inherit self pkgs;
              modules = [ inputs.sops-nix.darwinModules.default ];
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
            nix run https://flakehub.com/f/NixOS/nixpkgs/0.1#flake-checker
          '';
        };
      });
    };
}
