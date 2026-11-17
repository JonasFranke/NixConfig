{ pkgs, ... }:
let
  tokyoNightTheme = {
    package = pkgs.tokyonight-gtk-theme;
    name = "Tokyonight-Dark";
  };
in
{
  gtk = {
    enable = true;
    colorScheme = "dark";

    theme = tokyoNightTheme;
    gtk4.theme = tokyoNightTheme;
  };

  xdg.configFile."gtk-3.0/settings.ini".force = true;

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
