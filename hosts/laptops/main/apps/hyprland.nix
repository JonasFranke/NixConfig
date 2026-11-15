{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  cs = config.colorScheme.palette;
  # mkLuaInline lets us embed raw Lua expressions inside the settings attrset
  lua = lib.generators.mkLuaInline;
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/nord/a_video_game_graphics_of_a_forest_and_a_lake.png";
    hash = "sha256-xZR4++PKgvWCAuRKBVu2frSBZdsGfdb+lhYc4or0nQs=";
  };
in
{

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    systemd.enable = false;

    configType = "lua";

    settings = {
      mod = {
        _var = "SUPER";
      };
      terminal = {
        _var = "ghostty";
      };
      fileManager = {
        _var = "nautilus";
      };
      menu = {
        _var = "rofi -show drun";
      };
      browser = {
        _var = "zen-beta";
      };
      mail = {
        _var = "thunderbird";
      };

      monitor = [
        {
          output = "eDP-1";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
        {
          output = "HDMI-A-1";
          mode = "2560x1440@120";
          position = "auto";
          scale = "auto";
        }
        {
          output = "DP-1";
          disabled = true;
        }
        {
          output = "DP-2";
          disabled = true;
        }
      ];

      env = [
        {
          _args = [
            "XCURSOR_SIZE"
            "12"
          ];
        }
        {
          _args = [
            "HYPRCURSOR_SIZE"
            "12"
          ];
        }
        {
          _args = [
            "NIXOS_OZONE_WL"
            "1"
          ];
        }
      ];

      config = {
        general = {
          gaps_in = 2;
          gaps_out = 6;
          border_size = 3;
          col = {
            active_border = "0xff${cs.base07}";
            inactive_border = "0xff${cs.base01}";
          };
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 0;
          rounding_power = 4;
          active_opacity = 1.0;
          inactive_opacity = 1.0;
          wobble = {
            enabled = true;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "0xee${cs.base0F}";
          };
          blur = {
            enabled = true;
            size = 2;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
        };

        dwindle = {
          preserve_split = true;
        };

        master = {
          new_status = "master";
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        input = {
          kb_layout = "de";
          kb_variant = "nodeadkeys";
          follow_mouse = 1;
          sensitivity = 0;
          touchpad = {
            natural_scroll = false;
          };
        };
      };

      # -----------------------------------------------------------------------
      # Animation curves  →  hl.curve("name", { type = "bezier", points = ... })
      # -----------------------------------------------------------------------
      curve = [
        {
          _args = [
            "easeOutQuint"
            {
              type = "bezier";
              points = [
                [
                  0.23
                  1.0
                ]
                [
                  0.32
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "easeInOutCubic"
            {
              type = "bezier";
              points = [
                [
                  0.65
                  0.05
                ]
                [
                  0.36
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "linear"
            {
              type = "bezier";
              points = [
                [
                  0.0
                  0.0
                ]
                [
                  1.0
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "almostLinear"
            {
              type = "bezier";
              points = [
                [
                  0.5
                  0.5
                ]
                [
                  0.75
                  1.0
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "quick"
            {
              type = "bezier";
              points = [
                [
                  0.15
                  0.0
                ]
                [
                  0.1
                  1.0
                ]
              ];
            }
          ];
        }
      ];

      # -----------------------------------------------------------------------
      # Animation definitions  →  hl.animation({ leaf = ..., ... })
      # -----------------------------------------------------------------------
      animation = [
        {
          leaf = "global";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 5.39;
          bezier = "easeOutQuint";
        }
        {
          leaf = "windows";
          enabled = true;
          speed = 4.79;
          bezier = "easeOutQuint";
        }
        {
          leaf = "windowsIn";
          enabled = true;
          speed = 4.1;
          bezier = "easeOutQuint";
          style = "popin 87%";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 1.49;
          bezier = "linear";
          style = "popin 87%";
        }
        {
          leaf = "fadeIn";
          enabled = true;
          speed = 1.73;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeOut";
          enabled = true;
          speed = 1.46;
          bezier = "almostLinear";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 3.03;
          bezier = "quick";
        }
        {
          leaf = "layers";
          enabled = true;
          speed = 3.81;
          bezier = "easeOutQuint";
        }
        {
          leaf = "layersIn";
          enabled = true;
          speed = 4.0;
          bezier = "easeOutQuint";
          style = "fade";
        }
        {
          leaf = "layersOut";
          enabled = true;
          speed = 1.5;
          bezier = "linear";
          style = "fade";
        }
        {
          leaf = "fadeLayersIn";
          enabled = true;
          speed = 1.79;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeLayersOut";
          enabled = true;
          speed = 1.39;
          bezier = "almostLinear";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 1.94;
          bezier = "almostLinear";
          style = "fade";
        }
        {
          leaf = "workspacesIn";
          enabled = true;
          speed = 1.21;
          bezier = "almostLinear";
          style = "fade";
        }
        {
          leaf = "workspacesOut";
          enabled = true;
          speed = 1.94;
          bezier = "almostLinear";
          style = "fade";
        }
      ];

      bind = [
        {
          _args = [
            (lua "mod .. \" + Q\"")
            (lua "hl.dsp.exec_cmd(terminal)")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + C\"")
            (lua "hl.dsp.window.close()")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + M\"")
            (lua "hl.dsp.exit()")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + E\"")
            (lua "hl.dsp.exec_cmd(fileManager)")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + V\"")
            (lua "hl.dsp.window.float()")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + R\"")
            (lua "hl.dsp.exec_cmd(menu)")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + B\"")
            (lua "hl.dsp.exec_cmd(browser)")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + T\"")
            (lua "hl.dsp.exec_cmd(mail)")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + P\"")
            (lua "hl.dsp.window.pseudo()")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + X\"")
            (lua "hl.dsp.exec_cmd(\"spotify\")")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + SHIFT + L\"")
            (lua "hl.dsp.exec_cmd(\"hyprlock\")")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + G\"")
            (lua "hl.dsp.exec_cmd(\"hyprshot -m region --clipboard-only\")")
          ];
        }

        {
          _args = [
            (lua "mod .. \" + left\"")
            (lua "hl.dsp.focus({ direction = \"l\" })")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + right\"")
            (lua "hl.dsp.focus({ direction = \"r\" })")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + up\"")
            (lua "hl.dsp.focus({ direction = \"u\" })")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + down\"")
            (lua "hl.dsp.focus({ direction = \"d\" })")
          ];
        }

        # HJKL focus
        {
          _args = [
            (lua "mod .. \" + H\"")
            (lua "hl.dsp.focus({ direction = \"l\" })")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + K\"")
            (lua "hl.dsp.focus({ direction = \"u\" })")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + J\"")
            (lua "hl.dsp.focus({ direction = \"d\" })")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + L\"")
            (lua "hl.dsp.focus({ direction = \"r\" })")
          ];
        }

        # Special workspace (scratchpad)
        {
          _args = [
            (lua "mod .. \" + S\"")
            (lua "hl.dsp.workspace.toggle_special(\"magic\")")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + SHIFT + S\"")
            (lua "hl.dsp.window.move({ workspace = \"special:magic\" })")
          ];
        }

        # Workspace scroll with mouse wheel  (e+1 / e-1 = next/prev open workspace)
        {
          _args = [
            (lua "mod .. \" + mouse_down\"")
            (lua "hl.dsp.focus({ workspace = \"e+1\" })")
          ];
        }
        {
          _args = [
            (lua "mod .. \" + mouse_up\"")
            (lua "hl.dsp.focus({ workspace = \"e-1\" })")
          ];
        }
      ]
      # Workspace 1–9 binds: MOD+<num> and MOD+SHIFT+<num>
      ++ (builtins.concatLists (
        builtins.genList (
          i:
          let
            ws = i + 1;
            key = "code:1${toString i}";
          in
          [
            {
              _args = [
                (lua "mod .. \" + ${key}\"")
                (lua "hl.dsp.focus({ workspace = ${toString ws} })")
              ];
            }
            {
              _args = [
                (lua "mod .. \" + SHIFT + ${key}\"")
                (lua "hl.dsp.window.move({ workspace = ${toString ws} })")
              ];
            }
          ]
        ) 9
      ))
      # Mouse window management (mouse = true flag replaces old bindm)
      ++ [
        {
          _args = [
            (lua "mod .. \" + mouse:272\"")
            (lua "hl.dsp.window.drag()")
            { mouse = true; }
          ];
        }
        {
          _args = [
            (lua "mod .. \" + mouse:273\"")
            (lua "hl.dsp.window.resize()")
            { mouse = true; }
          ];
        }
      ]
      # Repeating binds for media/brightness (repeating = true replaces old binde)
      ++ [
        {
          _args = [
            "XF86AudioRaiseVolume"
            (lua "hl.dsp.exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+\")")
            { repeating = true; }
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (lua "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
            { repeating = true; }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (lua "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%+\")")
            { repeating = true; }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lua "hl.dsp.exec_cmd(\"brightnessctl -e4 -n2 set 5%-\")")
            { repeating = true; }
          ];
        }
      ]
      # Locked binds — work even on lock screen (locked = true replaces old bindl)
      ++ [
        {
          _args = [
            "XF86AudioMute"
            (lua "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioMicMute"
            (lua "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioNext"
            (lua "hl.dsp.exec_cmd(\"playerctl next\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPause"
            (lua "hl.dsp.exec_cmd(\"playerctl play-pause\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPlay"
            (lua "hl.dsp.exec_cmd(\"playerctl play-pause\")")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (lua "hl.dsp.exec_cmd(\"playerctl previous\")")
            { locked = true; }
          ];
        }
      ];

      window_rule = [
        # Zen browser: always on monitor 1, disable blur
        {
          match = {
            class = "^(zen-beta)$";
          };
          monitor = 1;
        }
        {
          match = {
            class = "^(zen-beta)$";
          };
          no_blur = true;
        }

        # Heroic launcher: workspace 3, no initial focus
        {
          match = {
            class = "^(heroic)$";
          };
          workspace = 3;
        }
        {
          match = {
            class = "^(heroic)$";
          };
          no_initial_focus = true;
        }

        # Ghostty: monitor 0
        {
          match = {
            class = "^(com.mitchellh.ghostty)$";
          };
          monitor = 0;
        }

        # Suppress maximize for all windows
        {
          match = {
            class = ".*";
          };
          suppress_event = "maximize";
        }

        # Spotify: monitor 0, no initial focus
        {
          match = {
            class = "^(spotify)$";
          };
          monitor = 0;
        }
        {
          match = {
            class = "^(spotify)$";
          };
          no_initial_focus = true;
        }

        # Zoom fixes
        {
          match = {
            class = "zoom";
            title = "Zoom Workplace";
          };
          no_initial_focus = true;
        }
        {
          match = {
            class = "zoom";
            title = "menu window";
          };
          no_initial_focus = true;
        }
        {
          match = {
            class = "zoom";
            title = "menu window";
          };
          float = true;
        }
        {
          match = {
            class = "zoom";
            title = "menu window";
          };
          move = "onscreen cursor";
        }
      ];
    };

    # -------------------------------------------------------------------------
    # Autostart via hl.on("hyprland.start", ...)
    # This runs on every config load/reload.
    # -------------------------------------------------------------------------
    extraConfig = ''
      -- Autostart
      hl.on("hyprland.start", function()
        hl.exec_cmd(terminal)
        hl.exec_cmd(browser)
        hl.exec_cmd("waybar")
        hl.exec_cmd("hyprsunset -t 5200")
        hl.exec_cmd("systemctl --user start hyprpolkitagent")
        hl.exec_cmd("hyprnotify")
        hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
      end)
    '';
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;
      wallpaper = [
        {
          monitor = "";
          path = "${wallpaper}";
        }
      ];
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      "$font" = "Monospace";
      general = {
        hide_cursor = false;
      };

      animations = {
        enabled = true;
        bezier = "linear, 1, 1, 0, 0";
        animation = [
          "fadeIn, 1, 5, linear"
          "fadeOut, 1, 5, linear"
          "inputFieldDots, 1, 2, linear"
        ];
      };

      background = {
        path = "${wallpaper}";
      };

      input-field = {
        size = "20%, 5%";
        outline_thickness = 3;

        inner_color = "rgba(0, 0, 0, 0.8)";
        outer_color = "rgb(${cs.base05}) rgb(${cs.base01}) 45deg";
        check_color = "rgb(${cs.base06}) rgb(${cs.base05}) 120deg";
        fail_color = "rgb(${cs.base08}) rgb(770000) 40deg";
        font_color = "rgb(${cs.base05})";

        placeholder_text = "<i>ENTER PASSWORD...</i>";

        fade_on_empty = false;
        rounding = 15;

        font_family = "$font";
        fail_text = "$PAMFAIL";

        dots_spacing = 0.3;

        position = "0, -20";
        halign = "center";
        valign = "center";
      };

      label = [
        {
          text = "$TIME";
          font_size = 90;
          font_family = "$font";
          position = "-40, 0";
          halign = "right";
          valign = "top";
        }
        {
          text = "cmd[update:60000] date +'%A, %d %B %Y'";
          font_size = 35;
          font_family = "$font";
          position = "-30, -150";
          halign = "right";
          valign = "top";
        }
      ];
    };
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        before_sleep_cmd = "loginctl lock-session";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "brightnessctl -s set 10%";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 1000;
          on-timeout = "playerctl --player=firefox status 2>/dev/null | grep -q Playing || hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = ''if [ "$(playerctl --player=firefox status)" = "Paused" ]; then hyprctl dispatch dpms off; fi'';
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  # UWSM
  xdg.configFile."uwsm/env".text = ''
    export XCURSOR_SIZE=12
    export NIXOS_OZONE_WL=1
  '';

  xdg.configFile."uwsm/env-hyprland".text = ''
    export HYPRCURSOR_SIZE=12
  '';

}
