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
    ./apps/waybar/waybar.nix
    ./apps/zsh.nix
    ./apps/rofi.nix
    ./apps/direnv.nix
  ];

  services.ssh-agent.enable = true;

  services.nextcloud-client = {
    enable = true;
    startInBackground = true;
  };

  colorScheme = {
    slug = "hyprland_default";
    name = "Hyprland Default";
    author = "Vaxry (Adapted)";
    palette = {
      base00 = "1a1a1a"; # Background (Standard Hyprland Dark Grey)
      base01 = "242424"; # Lighter Background
      base02 = "33ccff"; # Selection Background (Hyprland Primary Cyan)
      base03 = "595959"; # Comments (Standard Inactive Border Color)
      base04 = "c5c8c6"; # Dark Foreground
      base05 = "ffffff"; # Default Text (Pure White)
      base06 = "f0f0f0"; # Light Foreground
      base07 = "ffffff"; # Light Background
      base08 = "ff5555"; # Red
      base09 = "ffb86c"; # Orange
      base0A = "f1fa8c"; # Yellow
      base0B = "00ff99"; # Green (Hyprland Secondary Gradient Color)
      base0C = "8be9fd"; # Cyan
      base0D = "33ccff"; # Blue/Accent (Hyprland Primary Gradient Color)
      base0E = "bd93f9"; # Purple
      base0F = "ff79c6"; # Brown/Pink (Matches the default Anime Wallpaper)
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
