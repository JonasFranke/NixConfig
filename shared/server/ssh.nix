{
  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "jonas" ];
      };
    };
    fail2ban.enable = true;
  };
}
