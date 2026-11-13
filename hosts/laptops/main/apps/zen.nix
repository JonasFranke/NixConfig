{ pkgs, ... }:
let
  nordicTheme = pkgs.fetchFromGitHub {
    owner = "daaniiieel";
    repo = "nord-firefox";
    rev = "b6b6e3da2c3dc5ddd822a1143c29d512bc4daf02";
    hash = "sha256-jH4qaeJiBMWX+pHkX4XObOvAwpLMWoFwGCPWqpFtQ68=";
  };
in
{
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    profiles.default.userChrome = "${nordicTheme}/userChrome.css";
  };
}
