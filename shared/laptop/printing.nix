{ pkgs, ... }: {
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      brlaser
      dcp9020cdw-cupswrapper
      dcp9020cdwlpr
      samsung-unified-linux-driver
    ];
  };
  services.ipp-usb.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

}
