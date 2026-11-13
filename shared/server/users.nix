{ pkgs, ... }: {
  users.users = {
    jonas = {
      isNormalUser = true;
      description = "Jonas";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
      packages = with pkgs; [ ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINDCCKK3H524fJmz82XqvD5KG8e1osjTiElYBaVOWeAu info@jonasfranke.xyz"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII5i3I19kN14wuPsbFmTTtL8UYHQ8Iq9eqkP+5qHLyvg jonasf@jf-unibook"
      ];
    };
  };

}
