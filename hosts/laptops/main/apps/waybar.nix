{
  config,
  pkgs,
  ...
}:
{
  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    settings.mainBar = {
      layer = "bottom";
      position = "top";
      height = 34;
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
        format-window-separator = " ";
        window-rewrite-default = "";
        window-rewrite = {
          "title<.*youtube.*>" = "";
          "title<.*github.*>" = "";
          "title<.*twitch.*>" = "󰕃";
          "title<.*Home Assistant.*>" = "󰟐";
          "class<zen-beta>" = "󰐾";
          "class<spotify>" = "";
          "class<com.mitchellh.ghostty>" = "";
          "class<discord>" = "";
          "class<steam>" = "󰓓";
          "class<jetbrains-idea>" = "";
          "class<jetbrains-studio>" = "";
          "class<prusa-slicer>" = "";
          "class<signal>" = "󰭹";
          "class<nemo>" = "";
          "class<thunderbird>" = "󰇮";
          "class<heroic>" = "󰊗";
          "class<ModrinthApp>" = "󰍳";
          "title<.*Minecraft.*>" = "󰍳";
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
        background-color: transparent;
      }

      #clock,
      #cpu,
      #memory,
      #network,
      #pulseaudio,
      #custom-shutdown,
      #custom-pv,
      #custom-plug,
      #custom-weather,
      #custom-spotify {
        padding: 0 10px 0 10px;
        margin: 0 5px 0 5px;
        opacity: 1;
        font-family: "FiraCode Nerd Font Mono", "JetBrains Mono", monospace;
        font-size: 12px;
        font-weight: bold;
        color: #${config.colorScheme.palette.base05};
      }


      #clock,
      #network,
      #cpu,
      #memory,
      #pulseaudio,
      #custom-shutdown,
      #custom-spotify {
        color: #${config.colorScheme.palette.base05};
        background-color: #${config.colorScheme.palette.base00};
      }

      #workspaces button {
        color: #${config.colorScheme.palette.base05};
        background: transparent;
        border-radius: 0px;
        margin: 0 5px 0 5px;
      }

      #workspaces button.active {
        color: #${config.colorScheme.palette.base05};
        background: #${config.colorScheme.palette.base01};
      }
    '';
  };
}
