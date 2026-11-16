{ config, pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.unstable.waybar;
    settings.mainBar = {
      layer = "bottom";
      position = "top";
      height = 34;
      modules-left = [ "hyprland/workspaces" ];
      modules-center = [
        "custom/spotify"
        "clock"
      ];
      modules-right = [
        "cpu"
        "memory"
        "pulseaudio"
        "backlight"
        "network"
        "battery"
        "custom/shutdown"
      ];

      "cpu" = {
        interval = 10;
        format = " {usage}%";
      };

      "memory" = {
        interval = 10;
        format = " {used}/{total}GB";
      };

      "clock" = {
        format = "{:%a %d.%m.%Y %H%Mh}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
      };

      "pulseaudio" = {
        format = "{icon} {volume}%";
        format-bluetooth = "{icon} {volume}% ";
        format-muted = "";
        format-icons = [
          ""
          ""
          ""
        ];
        on-click-right = "pavucontrol";
        on-click = "blueman-manager";
      };

      "backlight" = {
        device = "intel_backlight";
        format = "{icon} {percent}%";
        format-icons = [
          ""
          ""
        ];
      };

      "hyprland/workspaces" = {
        format = "{icon} {windows}";
        format-window-separator = " ";
        window-rewrite-default = "";
        window-rewrite = {
          "title<.*youtube.*>" = "";
          "title<.*github.*>" = "";
          "title<.*twitch.*>" = "󰕃";
          "title<.*whatsapp.*>" = "";
          "title<.*Home Assistant.*>" = "󰟐";
          "class<zen-beta>" = "󰐾";
          "class<spotify>" = "";
          "class<texstudio>" = "";
          "class<com.mitchellh.ghostty>" = "";
          "class<discord>" = "";
          "class<steam>" = "󰓓";
          "class<jetbrains-idea>" = "";
        };
      };

      "battery" = {
        format = "{icon} {capacity}%";
        format-charging = "󱐋{icon} {capacity}%";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        tooltip-format = "{timeTo} | {power}W | {health}%";
      };

      "network" = {
        format-wifi = " {essid} ({signalStrength}%) | ↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes}";
        tooltip-format-wifi = " {essid}@{frequency}GHz | {ipaddr} | ↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes}";
        format-ethernet = "󰊗 {ifname} | ↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes}";
        tooltip-format-ethernet = "󰊗 {ifname} | {ipaddr} | ↑ {bandwidthUpBytes} ↓ {bandwidthDownBytes}";
        interval = 20;
        on-click = "rofi-network-manager";
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
        color: #${config.colorScheme.palette.base05};
      }

      #clock,
      #cpu,
      #memory,
      #pulseaudio,
      #backlight,
      #battery,
      #network,
      #custom-shutdown,
      #custom-spotify {
        background-color: #${config.colorScheme.palette.base01};
        padding: 0 10px 0 10px;
        margin: 0 5px 0 5px;
        border-radius: 5px;
      }

      #workspaces button {
        color: #${config.colorScheme.palette.base05};
        background: transparent;
        border-radius: 5px;
        margin: 0 5px 0 5px;
      }

      #workspaces button.active {
        color: #${config.colorScheme.palette.base05};
        background: #${config.colorScheme.palette.base02};
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
