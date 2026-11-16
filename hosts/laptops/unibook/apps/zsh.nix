{ pkgs, ... }:
{
  home.packages = with pkgs; [
    cowsay
    lolcat
  ];
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    shellAliases = {
      gti = "git";
      gs = "git status";

      dev = "nix develop --command zsh";
      ssh-add = "ssh-add -t 1h";
      open = "xdg-open";
      sqlite3 = "rlwrap sqlite3";
      wttr = "curl \"wttr.in/bremen?lang=de\"";
    };

    initContent = ''
      if command -v keychain > /dev/null 2>&1; then eval $(keychain --eval --nogui /home/jonasf/.ssh/id_ed25519 --quiet); fi

      hour=$(date +%-H)

      if [ "$hour" -lt 12 ]; then
          greeting="Good morning"
      elif [ "$hour" -lt 18 ]; then
          greeting="Good afternoon"
      else
          greeting="Good evening"
      fi

      cowsay -f stegosaurus "$greeting, Jonas!" | lolcat
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "gh"
        "zoxide"
        "sudo"
        "bun"
      ];
      theme = "robbyrussell";
    };
  };

  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
    theme = ./tokyo-night.yaml;
    enableZshIntegration = true;
  };
}
