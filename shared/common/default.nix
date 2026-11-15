let
  dir = ./.;
  entries = builtins.readDir dir;
  files = builtins.filter (
    name:
    entries.${name} == "regular" && name != "default.nix" && builtins.match ".*\\.nix" name != null
  ) (builtins.attrNames entries);
in
{
  imports = map (name: dir + "/${name}") files;
}
