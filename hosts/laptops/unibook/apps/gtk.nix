{ ... }: {
  gtk = {
    enable = true;
  };

  xdg.configFile."gtk-3.0/settings.ini".force = true;

  qt = {
    enable = true;
  };
}
