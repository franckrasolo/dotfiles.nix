{
  description = "macOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-22.05-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nix-darwin, home-manager, sops-nix }:
    let
      platforms = [ "x86_64-darwin" "aarch64-darwin" ];

      pkgs = nixpkgs-unstable;

      user = rec {
        fullName = "Franck Rasolo";
        accountName = "franck.rasolo";
        homeDirectory = "/Users/${accountName}";
      };
    in
    {
      darwinConfigurations = {
        mbp64 = nix-darwin.lib.darwinSystem {
          system  = "x86_64-darwin";
          inputs  = { inherit nix-darwin pkgs; };
          modules = [
            ./darwin/configuration.nix
            home-manager.darwinModules.home-manager
            sops-nix.nixosModules.sops
          ];
          specialArgs = { inherit user; };
        };

        m1m64 = nix-darwin.lib.darwinSystem {
          system  = "aarch64-darwin";
          inputs  = { inherit nix-darwin pkgs; };
          modules = [
            { nix.extraOptions = ''extra-platforms = x86_64-darwin aarch64-darwin''; }
            ./darwin/configuration.nix
            home-manager.darwinModules.home-manager
            sops-nix.nixosModules.sops
          ];
          specialArgs = { inherit user; };
        };
      };

      checks = {
        x86_64-darwin.mbp64  = self.nix-darwin-configurations.mbp64.system;
        aarch64-darwin.m1m64 = self.nix-darwin-configurations.m1m64.system;
      };
    };
}
