{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  lua = lib.generators.mkLuaInline;
  wallpaper = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/dharmx/walls/refs/heads/main/architecture/a_city_skyline_with_mountains_in_the_background.png";
    hash = "sha256-dKVr2R/z/lFNhre++meang1BfDW55HhPdNgBXamUvXU=";
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
      config = {
        general = {
          gaps_in = 5;
          gaps_out = 8;
          border_size = 2;
          col = {
            active_border = {
              colors = [
                "rgba(${config.colorScheme.palette.base02}ee)"
                "rgba(${config.colorScheme.palette.base0B}ee)"
              ];
              angle = 45;
            };
            inactive_border = "rgba(${config.colorScheme.palette.base03}aa)";
          };
          resize_on_border = false;
          allow_tearing = false;
          layout = "dwindle";
        };
        decoration = {
          rounding = 8;
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
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 2;
            passes = 1;
            vibrancy = 0.1696;
          };
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
            natural_scroll = true;
          };
        };
      };

      # ── Monitors → hl.monitor({...}) per entry ───────────────────────────
      monitor = [
        {
          output = "eDP-1";
          mode = "preferred";
          position = "auto";
          scale = 1;
        }
        {
          output = "HDMI-A-1";
          mode = "preferred";
          position = "auto-up";
          scale = 1;
        }
        {
          output = "DP-1";
          mode = "preferred";
          position = "auto-up";
          scale = 1.5;
        }
        # { output = "DP-1"; mode = "preferred"; position = "auto-up"; scale = 1.5; mirror = "eDP-1"; }
        {
          output = "desc:Acer Technologies XZ322QU V3 000000000000";
          mode = "preferred";
          position = "auto-up";
          scale = "auto";
        }
      ];

      # ── Animation curves → hl.curve("name", {type, points}) ─────────────
      # _args renders the list as separate Lua arguments (not a nested table)
      curve = [
        {
          _args = [
            "easeOutQuint"
            {
              type = "bezier";
              points = [
                [
                  0.23
                  1
                ]
                [
                  0.32
                  1
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
                  1
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
                  0
                  0
                ]
                [
                  1
                  1
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
                  0
                ]
                [
                  0.1
                  1
                ]
              ];
            }
          ];
        }
      ];

      # ── Animations → hl.animation({...}) per entry ───────────────────────
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
          speed = 4;
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

      # ── Autostart → hl.on("hyprland.start", function() ... end) ──────────
      on = [
        {
          _args = [
            "hyprland.start"
            (lua ''
              function()
                  hl.exec_cmd("zen-beta")
                  hl.exec_cmd("ghostty")
                  hl.exec_cmd("waybar & hyprsunset -t 5500 & hyprnotify")
                  hl.exec_cmd("systemctl --user start hyprpolkitagent")
              end
            '')
          ];
        }
      ];

      # ── Keybindings → hl.bind(keys, dispatcher, flags?) per entry ────────
      # Each bind uses _args to pass the key string, dispatcher, and optional flags.
      # Dispatchers are inlined as raw Lua via lib.generators.mkLuaInline.
      bind = [
        # Lid switch → lock screen (locked so it fires even on lockscreen)
        {
          _args = [
            "switch:on:Lid Switch"
            (lua ''hl.dsp.exec_cmd("hyprlock")'')
            { locked = true; }
          ];
        }
      ];

      # ── Window rules → hl.window_rule({match = {...}, effect = ...}) ─────
      window_rule = [
        {
          match = {
            class = "^zen-beta$";
          };
          workspace = "2";
        }
        {
          match = {
            class = "^zen-beta$";
          };
          no_blur = true;
        }
        {
          match = {
            class = "^texstudio$";
          };
          workspace = "3";
        }
        {
          match = {
            class = "^com.mitchellh.ghostty$";
          };
          workspace = "1";
        }
        {
          match = {
            class = ".*";
          };
          suppress_event = "maximize";
        }
        # IntelliJ IDEA: suppress animation and auto-focus for floating popups
        {
          match = {
            class = "^jetbrains-.*$";
            title = "^win.*$";
          };
          no_anim = true;
          no_focus = true;
        }
      ];
    };

    # ── Workspace 1-9 binds (Lua loop – cannot be expressed in settings) ──
    extraLuaFiles."workspace-binds" = {
      autoLoad = true;
      content = ''
        -- Workspace switching for 1–9 using keycodes (layout-independent)
        for i = 1, 9 do
            local ws  = tostring(i)
            local key = "code:1" .. tostring(i - 1)
            hl.bind("SUPER + " .. key,           hl.dsp.focus({ workspace = ws        }))
            hl.bind("SUPER + SHIFT + " .. key,   hl.dsp.window.move({ workspace = ws  }))
        end
      '';
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
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

      auth = {
        fingerprint = {
          enabled = true;
        };
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
        path = "screenshot";
        blur_passes = 5;
      };

      input-field = {
        size = "20%, 5%";
        outline_thickness = 3;
        inner_color = "rgba(0, 0, 0, 0.0)";
        outer_color = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        check_color = "rgba(00ff99ee) rgba(ff6633ee) 120deg";
        fail_color = "rgba(ff6633ee) rgba(ff0066ee) 40deg";
        font_color = "rgb(143, 143, 143)";
        fade_on_empty = false;
        rounding = 15;
        font_family = "$font";
        placeholder_text = "Input password...";
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
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
