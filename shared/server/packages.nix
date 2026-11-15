{ pkgs, inputs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    fastfetch
    btop
    iperf
    inputs.nixvim.packages.${stdenv.hostPlatform.system}.default
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
