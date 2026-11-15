{ pkgs, config, ... }:
{
  services.borgbackup.jobs = {
    "opencloud" = {
      paths = [
        config.services.opencloud.stateDir
        "/etc/opencloud"
      ];
      doInit = true;
      repo = "ssh://jonas@100.81.106.95:22/home/jonas/opencloud";
      encryption = {
        mode = "none";
      };
      environment = {
        BORG_RSH = "ssh -i /root/.ssh/borg_ed25519";
      };
      compression = "auto,zstd";
      startAt = "daily";
      preHook = ''
        systemctl stop opencloud.service
      '';
      postHook = ''
        systemctl start opencloud.service

        token="$(cat ${config.age.secrets."opencloud-betterstack".path})"

        if [ "$exitStatus" -eq 0 ]; then
          ${pkgs.curl}/bin/curl -fsS --retry 3 -m 10 https://incidents.betterstack.com/api/v1/heartbeat/$token || true
        fi
      '';
      prune.keep = {
        within = "1d";
        daily = 3;
        weekly = 2;
      };
    };
  };
}
