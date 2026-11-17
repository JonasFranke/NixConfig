{ pkgs, ... }: {
  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    fira-code-symbols
    times-newer-roman
    montserrat
    noto-fonts-color-emoji
  ];
}
