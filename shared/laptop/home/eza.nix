{ config, ... }:
let
  c = config.lib.stylix.colors.withHashtag;
in
{
  programs.eza = {
    enable = true;
    theme = {
      filekinds = {
        directory.foreground = c.base0D;
        symlink.foreground = c.base0C;
        executable.foreground = c.base0B;
        pipe.foreground = c.base0A;
        socket.foreground = c.base0A;
      };
      perms = {
        user_read.foreground = c.base0A;
        user_write.foreground = c.base08;
        user_execute_file.foreground = c.base0B;
      };
      size = {
        number_byte.foreground = c.base04;
        number_kilo.foreground = c.base0B;
        number_mega.foreground = c.base0A;
        number_giga.foreground = c.base09;
      };
      date.foreground = c.base0E;
      users.user_you.foreground = c.base0D;
    };
  };
}
