{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.zst";
    nixvim-config = {
      type = "github";
      owner = "JonasFranke";
      repo = "NixVimConfig";
    };
    agenix = {
      type = "github";
      owner = "ryantm";
      repo = "agenix";
    };
  };
  outputs =
    { nixpkgs, agenix, ... }@inputs:
    {
      nixosConfigurations.opencloud = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./hosts/opencloud/configuration.nix
          agenix.nixosModules.default
        ];
      };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
