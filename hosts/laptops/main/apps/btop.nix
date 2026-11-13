{ config, pkgs, ... }: {
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "my_nord";
      theme_background = false;
    };
    themes = {
      my_nord = ''
        theme[main_bg]="#${config.colorScheme.palette.base00}"
        theme[main_fg]="#${config.colorScheme.palette.base06}"
        theme[title]="#${config.colorScheme.palette.base05}"
        theme[hi_fg]="#${config.colorScheme.palette.base0D}"
        theme[selected_bg]="#${config.colorScheme.palette.base02}"
        theme[selected_fg]="#${config.colorScheme.palette.base06}"
        theme[inactive_fg]="#${config.colorScheme.palette.base03}"
        theme[graph_text]="#${config.colorScheme.palette.base05}"
        theme[meter_bg]="#${config.colorScheme.palette.base02}"
        theme[proc_misc]="#${config.colorScheme.palette.base0D}"
        theme[div_line]="#${config.colorScheme.palette.base03}"

        # box outlines
        theme[cpu_box]="#${config.colorScheme.palette.base0C}"
        theme[mem_box]="#${config.colorScheme.palette.base0B}"
        theme[net_box]="#${config.colorScheme.palette.base0D}"
        theme[proc_box]="#${config.colorScheme.palette.base0E}"

        # temperature / cpu: green -> yellow -> red
        theme[temp_start]="#${config.colorScheme.palette.base0B}"
        theme[temp_mid]="#${config.colorScheme.palette.base0A}"
        theme[temp_end]="#${config.colorScheme.palette.base08}"
        theme[cpu_start]="#${config.colorScheme.palette.base0B}"
        theme[cpu_mid]="#${config.colorScheme.palette.base0A}"
        theme[cpu_end]="#${config.colorScheme.palette.base08}"

        # memory: used (high = bad), free/available (high = good)
        theme[used_start]="#${config.colorScheme.palette.base0B}"
        theme[used_mid]="#${config.colorScheme.palette.base0A}"
        theme[used_end]="#${config.colorScheme.palette.base08}"
        theme[free_start]="#${config.colorScheme.palette.base08}"
        theme[free_mid]="#${config.colorScheme.palette.base0A}"
        theme[free_end]="#${config.colorScheme.palette.base0B}"
        theme[available_start]="#${config.colorScheme.palette.base08}"
        theme[available_mid]="#${config.colorScheme.palette.base0A}"
        theme[available_end]="#${config.colorScheme.palette.base0B}"
        theme[cached_start]="#${config.colorScheme.palette.base0C}"
        theme[cached_mid]="#${config.colorScheme.palette.base0D}"
        theme[cached_end]="#${config.colorScheme.palette.base0E}"

        # network
        theme[download_start]="#${config.colorScheme.palette.base0C}"
        theme[download_mid]="#${config.colorScheme.palette.base0D}"
        theme[download_end]="#${config.colorScheme.palette.base0F}"
        theme[upload_start]="#${config.colorScheme.palette.base0E}"
        theme[upload_mid]="#${config.colorScheme.palette.base0D}"
        theme[upload_end]="#${config.colorScheme.palette.base0C}"

        # processes
        theme[process_start]="#${config.colorScheme.palette.base0B}"
        theme[process_mid]="#${config.colorScheme.palette.base0A}"
        theme[process_end]="#${config.colorScheme.palette.base08}"
      '';
    };
  };
}
