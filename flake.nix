{
  description = "NixOS configuration for veer";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-shell.url = "github:caelestia-dots/shell";
    areofyl-fetch.url = "github:areofyl/fetch";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, areofyl-fetch, sops-nix, ... }@inputs:
    let
      vars = import ./vars.nix;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
    in {
      packages.${system}.purge = pkgs.callPackage ./sys-modules/purge.nix { };

      overlays.${system} = final: prev: {
        purge = final.callPackage ./sys-modules/purge.nix { };
        opencode = pkgs-unstable.opencode;
      };

      nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
        system = system;

        specialArgs = { inherit inputs vars pkgs-unstable; };
        modules = [
          ./configuration.nix

          ({ ... }: {
            nixpkgs.overlays = [ self.overlays.${system} ];
          })

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.${vars.username} = import ./home.nix;

            home-manager.extraSpecialArgs = { inherit inputs vars pkgs-unstable; };
          }
        ];
      };
    };
}
