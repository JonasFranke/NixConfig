{ config, pkgs, ... }:
let
  port = 9200;
  baseURL = "https://github.com/opencloud-eu/web-extensions/releases/download";

  unzipApp = pkgs.fetchzip {
    name = "opencloud-unzip";
    url = "${baseURL}/unzip-v2.2.1/unzip-2.2.1.zip";
    hash = "sha256-fRmuIyP2HapfOdkU/90pCt78hmxe6DAB1E17qpGiwEE=";
  };

  externalSitesApp = pkgs.fetchzip {
    name = "opencloud-external-sites";
    url = "${baseURL}/external-sites-v2.1.0/external-sites-2.1.0.zip";
    hash = "sha256-dG8/0HKG/KUzSg1oQgtBel8XEt5RI4eTdYz5cthXG0k=";
  };

  opencloudApps = pkgs.runCommand "opencloud-apps" { } ''
    mkdir -p $out/unzip $out/external-sites
    cp -r ${unzipApp}/* $out/unzip/
    cp -r ${externalSitesApp}/* $out/external-sites/
  '';
in
{
  services.opencloud = {
    enable = true;
    package = pkgs.opencloud;
    url = "https://ocloud.jonasfranke.xyz";

    address = "0.0.0.0";
    port = port;

    environmentFile = config.age.secrets."opencloud-resend".path;

    environment = {
      # Disable internal TLS since NPM terminates SSL upstream
      PROXY_TLS = "false";

      WEB_ASSET_APPS_PATH = "${opencloudApps}";

      # SMTP
      START_ADDITIONAL_SERVICES = "notifications";
      NOTIFICATIONS_SMTP_HOST = "smtp.resend.com";
      NOTIFICATIONS_SMTP_PORT = "25";
      NOTIFICATIONS_SMTP_SENDER = "cloud@jonasfranke.xyz";
      NOTIFICATIONS_SMTP_USERNAME = "resend";
      NOTIFICATIONS_SMTP_ENCRYPTION = "starttls";
      NOTIFICATIONS_SMTP_INSECURE = "false";
      NOTIFICATIONS_SMTP_AUTHENTICATION = "auto";
    };
  };

  networking.firewall.allowedTCPPorts = [ port ];
}
