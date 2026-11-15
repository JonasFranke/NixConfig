{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      substituters = [
        "https://cache.nixos.org/"
        "https://jonasfranke.cachix.org"
        "https://hyprland.cachix.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-wayland.cachix.org"
      ];

      trusted-substituters = [ "https://hyprland.cachix.org" ];

      trusted-public-keys = [
        "jonasfranke.cachix.org-1:3nZ2r+ZbqkEi1Iu75vv/Kth9v5eTqzvSoqqDUcZ0acA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    optimise.automatic = true;
  };
}
