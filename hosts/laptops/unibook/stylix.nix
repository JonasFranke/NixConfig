{ pkgs, ... }: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    polarity = "dark";
    autoEnable = true;

    targets = {
      # kmscon uses deprecated NixOS options in this nixpkgs version
      kmscon.enable = false;
      # Keep the custom minegrub theme from configuration.nix
      grub.enable = false;
    };
  };
}
