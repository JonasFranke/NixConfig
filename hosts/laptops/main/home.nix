{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  folder = ./apps;

  files = builtins.readDir folder;

  validFiles = lib.filterAttrs (
    name: type:
    (type == "regular" || type == "symlink") && (lib.hasSuffix ".nix" name) && (name != "default.nix")
  ) files;

  importsList = map (name: folder + "/${name}") (builtins.attrNames validFiles);
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jonas";
  home.homeDirectory = "/home/jonas";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    cowsay
    lolcat
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  home.sessionVariables = { };

  disabledModules = [
    "services/window-managers/hyprland.nix"
  ];

  imports = importsList ++ [
    "${inputs.home-manager-unstable}/modules/services/window-managers/hyprland.nix"
    inputs.zen-browser.homeModules.beta
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  colorScheme = import ./theme.nix;

  services.ssh-agent.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
