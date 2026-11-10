{
  description = "aragorn NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Prebuilt nix-index database: command-not-found handler + comma (`, <cmd>`)
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Declarative KDE Plasma settings (shortcuts, panels, ...) via Home Manager
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # Declarative Flatpak remotes/apps (latest tagged release)
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    # Helium browser (prebuilt upstream tarball, bot-updated)
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nix-index-database,
      plasma-manager,
      nix-flatpak,
      helium,
      ...
    }@inputs:
    {
      # `nix fmt` formats every .nix file in the repo
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;

      nixosConfigurations.aragorn = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/aragorn
          nix-flatpak.nixosModules.nix-flatpak

          # Make unstable packages available as pkgs.unstable.<name>
          {
            nixpkgs.overlays = [
              helium.overlays.default # pkgs.helium
              (final: prev: {
                unstable = import nixpkgs-unstable {
                  system = prev.stdenv.hostPlatform.system;
                  config.allowUnfree = true;
                };
              })
            ];
          }

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true; # HM uses the system pkgs (including the overlay and allowUnfree)
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [
              nix-index-database.homeModules.nix-index
              plasma-manager.homeModules.plasma-manager
            ];
            home-manager.users.vmpyr = import ./home;
          }
        ];
      };
    };
}
