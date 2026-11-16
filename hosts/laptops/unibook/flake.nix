{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable-small/nixexprs.tar.zst";
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    zen-browser = {
      type = "github";
      owner = "0xc000022070";
      repo = "zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hyprland = {
      type = "github";
      owner = "hyprwm";
      repo = "Hyprland";
      ref = "v0.57.2";
    };
    nixvim = {
      type = "github";
      owner = "jonasfranke";
      repo = "nixvimconfig";
    };
    nix-colors.url = "github:misterio77/nix-colors";
    nixos-grub-themes = {
      url = "github:jeslie0/nixos-grub-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nix-colors,
      ...
    }@inputs:
    {
      nixosConfigurations.jf-unibook = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ({ ... }: {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                (self: super: {
                  unstable = import nixpkgs-unstable {
                    system = "x86_64-linux";
                    config.allowUnfree = true;
                  };
                })
              ];
            };
          })
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.jonasf = {
              imports = [
                ./home.nix
                nix-colors.homeManagerModules.default
              ];
            };
          }
        ];
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
