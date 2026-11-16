{
  programs.virt-manager.enable = true;
  virtualisation = {
    docker.enable = true;
    containers.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };
}
