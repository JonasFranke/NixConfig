{ lib, ... }:
let
  lua = lib.generators.mkLuaInline;
in
{
  wayland.windowManager.hyprland.settings = {
    mod = {
      _var = "SUPER";
    };
    terminal = {
      _var = "ghostty";
    };
    fileManager = {
      _var = "nemo";
    };
    menu = {
      _var = "rofi -show drun";
    };
    browser = {
      _var = "zen-beta";
    };

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
  };
}
