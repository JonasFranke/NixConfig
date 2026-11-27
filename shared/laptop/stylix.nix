{
  stylix = {
    enable = true;
    polarity = "dark";
    autoEnable = true;

    targets = {
      # kmscon uses deprecated NixOS options in this nixpkgs version
      kmscon.enable = false;
    };
  };
}
