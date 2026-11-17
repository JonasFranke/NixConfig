let
  jonas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINDCCKK3H524fJmz82XqvD5KG8e1osjTiElYBaVOWeAu";
  jonasf = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5i3I19kN14wuPsbFmTTtL8UYHQ8Iq9eqkP+5qHLyvg";
  users = [ jonas jonasf ];

  opencloud = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH4lGYYnNcwUK23Yl3tGRQdaraKTaiMDuLvq9YuGVxnw";
  nixos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIClNi2DLnPx4aYXcyt2T6rfwiqZIXYTsWNfemqc5D4qo"; # Main laptop
  unibook = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcYnaqDLIfmSCh7Q1C8j0fBicEIMwGrWTw3ynyoBX2S";
  systems = [
    opencloud
    nixos
    unibook
  ];
in
{
  "github-key.age".publicKeys = users ++ systems;
  "opencloud-betterstack.age".publicKeys = users ++ [ opencloud ];
  "opencloud-resend.age".publicKeys = users ++ [ opencloud ];
}
