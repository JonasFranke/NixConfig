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
      ];

      trusted-public-keys = [
        "jonasfranke.cachix.org-1:3nZ2r+ZbqkEi1Iu75vv/Kth9v5eTqzvSoqqDUcZ0acA="
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
