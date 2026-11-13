{ pkgs, ... }:
let
  nordicTheme = {
    package = pkgs.nordic;
    name = "Nordic-darker";
  };
in
{
  gtk = {
    enable = true;
    colorScheme = "dark";

    theme = nordicTheme;
    gtk4.theme = nordicTheme;

    iconTheme = {
      name = "Nordic-darker";
    };
  };
  xdg.configFile."gtk-3.0/settings.ini".force = true;

  qt = {
    enable = true;
    platformTheme.name = "gtk";
  };
}
