{
  description = "macOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # provides the latest build of Zellij until a release truly
    # fixes https://github.com/zellij-org/zellij/issues/3208
    zellij = {
      url = "github:a-kenji/zellij-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, zellij, zjstatus }:
    let
      platforms = [ "x86_64-darwin" "aarch64-darwin" ];

      overlay = final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (prev) system;
          config.allowBroken = true;
          config.allowUnfree = true;
          config.packageOverrides = prev: import ./pkgs { inherit (prev) pkgs; };
          config.permittedInsecurePackages = [
            "libxls-1.6.2"
          ];
        };

        presenterm-with-sixel = with final.unstable.pkgs; presenterm.overrideAttrs (attrs: {
          cargoBuildFeatures = attrs.cargoBuildFeatures ++ lib.optional stdenv.isDarwin [ "sixel" ];
          # fix for macOS:
          #   Crashes at runtime on darwin with:
          #   Library not loaded: .../out/lib/libsixel.1.dylib
          #
          # The sixel-sys crate used by presenterm is dynamically linked to libsixel.
          #
          # sources:
          #   https://github.com/NixOS/nixpkgs/pull/249210/files
          #   https://github.com/NixOS/nixpkgs/pull/297078/files
          nativeBuildInputs = attrs.nativeBuildInputs ++ [ makeWrapper ];
          postInstall = (attrs.postInstall or "") + lib.optionalString stdenv.isDarwin ''
            wrapProgram $out/bin/presenterm \
              --prefix DYLD_LIBRARY_PATH : "${lib.makeLibraryPath [ libsixel ]}"
          '';
        });

        zellij-latest = zellij.packages."${prev.system}".zellij;
        zjstatus = zjstatus.packages.${prev.system}.default;
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
            nix run "github:DeterminateSystems/flake-checker"
          '';
        };
      });
    };
}
