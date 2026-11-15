{ config, ... }: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "FiraCode Nerd Font";
      background = "#${config.colorScheme.palette.base00}";
      foreground = "#${config.colorScheme.palette.base05}";
      selection-background = "#${config.colorScheme.palette.base05}";
      selection-foreground = "#${config.colorScheme.palette.base00}";
      cursor-color = "#${config.colorScheme.palette.base05}";
      cursor-style = "block";
      background-opacity = 0.45;
      background-blur = true;

      keybind = [
        # Splits (tmux: C-b % = vsplit, C-b " = hsplit)
        "ctrl+t>%=new_split:right"
        "ctrl+t>\"=new_split:down"

        # Pane navigation (tmux: C-b + arrow)
        "ctrl+t>left=goto_split:left"
        "ctrl+t>right=goto_split:right"
        "ctrl+t>up=goto_split:up"
        "ctrl+t>down=goto_split:down"

        # Zoom / kill pane
        "ctrl+t>z=toggle_split_zoom"
        "ctrl+t>x=close_surface"

        # Windows -> tabs
        "ctrl+t>c=new_tab"
        "ctrl+t>n=next_tab"
        "ctrl+t>p=previous_tab"
        "ctrl+t>&=close_tab"

        # Force literal ctrl+t through if you ever need it (transpose-chars)
        "ctrl+t>ctrl+t=text:\u0014"

        "alt+left=esc:b"
        "alt+right=esc:f"
      ];
    };
  };
}
