{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jonasf";
  home.homeDirectory = "/home/jonasf";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [ ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  home.sessionVariables = { };

  disabledModules = [
    "services/window-managers/hyprland.nix"
  ];

  imports = [
    "${inputs.home-manager-unstable}/modules/services/window-managers/hyprland.nix"
    ./apps/hyprland.nix
    ./apps/ghostty.nix
    ./apps/waybar.nix
    ./apps/eza.nix
    ./apps/rofi.nix
    ./apps/gtk.nix
    ../../../shared/laptop/home
  ];

  services.ssh-agent.enable = true;

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
