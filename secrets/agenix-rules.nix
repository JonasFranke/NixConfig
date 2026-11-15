let
  jonas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINDCCKK3H524fJmz82XqvD5KG8e1osjTiElYBaVOWeAu";
  users = [ jonas ];

  opencloud = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4lGYYnNcwUK23Yl3tGRQdaraKTaiMDuLvq9YuGVxnw";
  nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIClNi2DLnPx4aYXcyt2T6rfwiqZIXYTsWNfemqc5D4qo"; # Main laptop
  systems = [
    opencloud
    nixos
  ];
in
{
  "github-key.age".publicKeys = users ++ systems;
  "opencloud-betterstack.age".publicKeys = users ++ [ opencloud ];
  "opencloud-resend.age".publicKeys = users ++ [ opencloud ];
}
