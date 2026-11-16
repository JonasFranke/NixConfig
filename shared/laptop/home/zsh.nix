{
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;

    shellAliases = {
      gti = "git";
      dev = "nix develop --command zsh";
      sqlite3 = "rlwrap sqlite3";
      gs = "git status";
      rebuild = "sudo nixos-rebuild switch --flake ~/NixConfig#$(hostname)";
      update = "cd ~/NixConfig && nix flake update && sudo nixos-rebuild switch --flake .#$(hostname)";
    };

    initContent = ''
      hour=$(date +%-H)

      if [ "$hour" -lt 12 ]; then
          greeting="Good morning"
      elif [ "$hour" -lt 18 ]; then
          greeting="Good afternoon"
      else
          greeting="Good evening"
      fi

      cowsay -f fox "$greeting, Jonas!" | lolcat -S 2
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "gh"
        "zoxide"
        "sudo"
        "bun"
        "ssh-agent"
      ];
      extraConfig = ''
        zstyle :omz:plugins:ssh-agent identities id_ed25519
      '';
      theme = "robbyrussell";
    };
  };

  programs.eza = {
    enable = true;
    git = true;
    enableZshIntegration = true;
    icons = "auto";
  };
}
