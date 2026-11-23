{ ... }: {
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      font-family = "FiraCode Nerd Font";
      cursor-style = "block";
      background-opacity = 0.45;
      background-blur = true;

      keybind = [
        # Splits (tmux: C-b % / C-b ")
        "ctrl+t>shift+5=new_split:right" # %
        "ctrl+t>shift+2=new_split:down" # "

        # Windows -> tabs
        "ctrl+t>shift+6=close_tab" # &

        # Panes
        "ctrl+t>shift+comma=goto_split:previous" # ;

        "ctrl+t>shift+period=toggle_command_palette" # :

        # Pane navigation (vim motions)
        "ctrl+t>h=goto_split:left"
        "ctrl+t>j=goto_split:down"
        "ctrl+t>k=goto_split:up"
        "ctrl+t>l=goto_split:right"

        # Pane navigation (tmux: C-b + arrow)
        "ctrl+t>left=goto_split:left"
        "ctrl+t>right=goto_split:right"
        "ctrl+t>up=goto_split:up"
        "ctrl+t>down=goto_split:down"

        # Pane resize (shift+hjkl, like the common tmux "resize-pane -L/D/U/R" binds)
        "ctrl+t>shift+h=resize_split:left,20"
        "ctrl+t>shift+j=resize_split:down,20"
        "ctrl+t>shift+k=resize_split:up,20"
        "ctrl+t>shift+l=resize_split:right,20"

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
