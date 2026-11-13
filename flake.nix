{
  inputs = {
    nixpkgs-stable.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.zst";
    nixpkgs-unstable.url = "https://channels.nixos.org/nixos-unstable-small/nixexprs.tar.zst";
    nixvim-config = {
      type = "github";
      owner = "JonasFranke";
      repo = "NixVimConfig";
    };
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "release-26.05";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager-unstable = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";
    };
    hyprland = {
      type = "github";
      owner = "hyprwm";
      repo = "Hyprland";
      ref = "v0.57.2";
    };
    zen-browser = {
      type = "github";
      owner = "0xc000022070";
      repo = "zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs =
    {
      nixpkgs-stable,
      agenix,
      nixpkgs-unstable,
      hyprland,
      nix-colors,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        opencloud = nixpkgs-unstable.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ./hosts/servers/opencloud/configuration.nix
            agenix.nixosModules.default
          ];
        };
        nixos = nixpkgs-stable.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
            ({ ... }: {
              nixpkgs = {
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

            ./hosts/laptops/main/configuration.nix
            agenix.nixosModules.default
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.jonas = {
                imports = [
                  ./hosts/laptops/main/home.nix
                  nix-colors.homeManagerModules.default
                  hyprland.homeManagerModules.default
                ];
              };
            }
          ];
        };
      };
      formatter.x86_64-linux = nixpkgs-unstable.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
