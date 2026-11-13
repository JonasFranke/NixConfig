{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "sudo" ];
      theme = "ys";
    };

    shellAliases = {
      ll = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";
      rebuild = "sudo nixos-rebuild switch --flake ~/NixConfig#$(hostname)";
      update = "cd ~/NixConfig && nix flake update && sudo nixos-rebuild switch --flake .#$(hostname)";
    };
  };
  users.defaultUserShell = pkgs.zsh;
}
