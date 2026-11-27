{
  config,
  pkgs,
  ...
}:
let
  colors = config.lib.stylix.colors.withHashtag;
in
{
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    settings.mainBar = {
      layer = "bottom";
      position = "top";
      height = 25;
      modules-left = [
        "hyprland/workspaces"
      ];
      modules-center = [
        "custom/spotify"
        "clock"
        "custom/weather"
      ];
      modules-right = [
        "cpu"
        "memory"
        "network"
        "pulseaudio"
        "custom/shutdown"
      ];

      "cpu" = {
        interval = 10;
        format = " {usage}%";
      };

      "memory" = {
        interval = 10;
        format = " {used:0.1f}/{total:0.1f}GB";
      };

      "network" = {
        format-wifi = " {essid} ({signalStrength}%) ↑ {bandwidthUpBytes} | ↓ {bandwidthDownBytes}";
        format = "{ifname}";
        tooltip-format = "{ifname}: {essid}@{frequency}GHz: {ipaddr}";
        interval = 30;
        on-click = "rofi-network-manager";
      };

      "clock" = {
        format = "{:%d.%m.%Y %H%Mh}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
      };

      "pulseaudio" = {
        format = " {volume}%";
        format-bluetooth = " {volume}% ";
        format-muted = "";
        on-click-right = "pavucontrol";
        on-click = "blueman-manager";
      };

      "hyprland/workspaces" = {
        format = "{icon} {windows}";
        workspace-taskbar = {
          enable = true;
          icon-size = 12;
          icon-theme = "Papirus";
        };
      };

      "custom/shutdown" = {
        format = "🔌";
        tooltip = "Shutdown, Reboot, Logout";
        on-click = "rofi -show power-menu -modi power-menu:rofi-power-menu --choices=shutdown/reboot";
      };

      "custom/spotify" = {
        format = " {text}";
        exec = "playerctl --player=spotify metadata --format '{\"text\": \"{{ title }} by {{ artist }}\"}'";
        return-type = "json";
        interval = 5;
      };
    };

    style = ''
      window#waybar {
        background-color: rgba(51, 51, 51, 0.5);
        opacity: 0.85;
      }

      * {
        font-family: "FiraCode Nerd Font Mono", "JetBrains Mono", monospace;
        font-size: 13px;
        color: ${colors.base05};
      }

      #clock,
      #cpu,
      #memory,
      #pulseaudio,
      #network,
      #custom-shutdown,
      #custom-spotify {
        background-color: ${colors.base01};
        padding: 0 10px 0 10px;
        margin: 0 5px 0 5px;
        border-radius: 5px;
      }

      #workspaces button {
        color: ${colors.base05};
        background: transparent;
        border-radius: 5px;
        margin: 0 5px 0 5px;
      }

      #workspaces button.active {
        color: ${colors.base05};
        background: ${colors.base02};
      }

      #workspaces .taskbar-window {
        padding-left: 0;
        padding-right: 0;
        padding-top: 0;
        padding-bottom: 0;
      }

      #clock:hover,
      #cpu:hover,
      #memory:hover,
      #pulseaudio:hover,
      #workspaces button:hover,
      #custom-shutdown:hover,
      #custom-spotify:hover {
        background-color: #999999;
        transition: background-color 0.3s ease-out;
      }
    '';
  };
}
