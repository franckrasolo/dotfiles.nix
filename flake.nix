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

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-darwin, sops-nix, home-manager, zjstatus }:
    let
      platforms = [ "x86_64-darwin" "aarch64-darwin" ];

      overlay = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (prev.stdenv.hostPlatform) system;
          config.allowBroken = true;
          config.allowUnfree = true;
          config.packageOverrides = prev: import ./pkgs { inherit (prev) pkgs; };
          config.permittedInsecurePackages = [
            "libxls-1.6.2"
          ];
        };

        zjstatus = zjstatus.packages.${prev.stdenv.hostPlatform.system}.default;
      };
      # makes "pkgs.unstable" available in configuration.nix
      overlayModule = ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay ]; });

      user = rec {
        fullName = "Franck Rasolo";
        accountName = "franck.rasolo";
        homeDirectory = "/Users/${accountName}";
      };

      forAllSystems = f: nixpkgs.lib.genAttrs platforms (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      darwinConfigurations = {
        mbp64 = nix-darwin.lib.darwinSystem {
          system  = "x86_64-darwin";
          inputs  = { inherit nix-darwin nixpkgs; };
          modules = [
            overlayModule
            ./darwin/configuration.nix
            sops-nix.darwinModules.sops
            home-manager.darwinModules.home-manager
          ];
          specialArgs = { inherit user; };
        };

        m3max = nix-darwin.lib.darwinSystem {
          system  = "aarch64-darwin";
          inputs  = { inherit nix-darwin nixpkgs; };
          modules = [
            { nix.extraOptions = ''extra-platforms = aarch64-darwin x86_64-darwin''; }
            overlayModule
            ./darwin/configuration.nix
            sops-nix.darwinModules.sops
            home-manager.darwinModules.home-manager {
              home-manager.extraSpecialArgs = { inherit user; };
            }
          ];
          specialArgs = { inherit user; };
        };
      };

      checks = {
        x86_64-darwin.mbp64  = self.nix-darwin-configurations.mbp64.system;
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
