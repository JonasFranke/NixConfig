{ ... }:
{
  imports = [
    ./nix-settings.nix
    ./users.nix
    ./zsh.nix
    ./tailscale.nix
    ./tmux.nix
    ./packages.nix
    ./secrets.nix
  ];
}
