{ config, pkgs, ... }: {
  programs.rofi = {
    enable = true;
    theme =
      let
        inherit (config.colorScheme) palette;
      in
      builtins.toFile "config-hypr.rasi" ''
        * {
          bg0: #${palette.base00}; // Nord0: Polar Night - Der Haupt-Hintergrund (Dunkelgrau, ~95% deckend)
          bg1: #${palette.base01};   // Nord1: Polar Night - Hellerer Hintergrund (oft für UI-Elemente/Leisten)
          bg2: #${palette.base03}; // Nord3: Polar Night - Inaktive Elemente / Auswahl (Grau, 50% transparent)
          bg3: #${palette.base0D}; // Nord8: Frost - Der typische Cyan-Akzent (Hellblau/Türkis, ~95% deckend)
          fg0: #${palette.base06};   // Nord4: Snow Storm - Standard Textfarbe (Weiß-Grau)
          fg1: #${palette.base05};   // Nord6: Snow Storm - Hervorgehobener Text (Hellstes Weiß)
          fg2: #${palette.base06};   // Nord4: Snow Storm - Sekundärer Text (Gleiche Farbe wie fg0)
          fg3: #${palette.base03};   // Nord3: Polar Night - Gedimmter Text / Kommentare / Platzhalter (Grau)
        }

        element selected {
          text-color: @bg1;
        }

        /* ROUNDED THEME FOR ROFI */
        /* Author: Newman Sanchez (https://github.com/newmanls) */

        * {
          font:   "Roboto 12";

          background-color:   transparent;
          text-color:         @fg0;

          margin:     0px;
          padding:    0px;
          spacing:    0px;
        }

        window {
            location:       north;
            y-offset:       calc(50% - 176px);
            width:          480;
            border-radius:  24px;

            background-color:   @bg0;
        }

        mainbox {
            padding:    12px;
        }

        inputbar {
            background-color:   @bg1;
            border-color:       @bg3;

            border:         2px;
            border-radius:  16px;

            padding:    8px 16px;
            spacing:    8px;
            children:   [ prompt, entry ];
        }

        prompt {
            text-color: @fg2;
        }

        entry {
            placeholder:        "Search";
            placeholder-color:  @fg3;
        }

        message {
            margin:             12px 0 0;
            border-radius:      16px;
            border-color:       @bg2;
            background-color:   @bg2;
        }

        textbox {
            padding:    8px 24px;
        }

        listview {
            background-color:   transparent;

            margin:     12px 0 0;
            lines:      8;
            columns:    1;

            fixed-height: false;
        }

        element {
            padding:        8px 16px;
            spacing:        8px;
            border-radius:  16px;
        }

        element normal active {
            text-color: @bg3;
        }

        element alternate active {
            text-color: @bg3;
        }

        element selected normal, element selected active {
            background-color:   @bg3;
        }

        element-icon {
            size:           1em;
            vertical-align: 0.5;
        }

        element-text {
            text-color: inherit;
        }

      '';
  };
}
#    theme = "/home/jonasf/.local/share/rofi/themes/rounded-nord-dark.rasi";
