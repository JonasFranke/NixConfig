{ pkgs, ... }: {
  stylix = {
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    # Keep the custom minegrub theme from configuration.nix
    targets.grub.enable = false;
  };
}
