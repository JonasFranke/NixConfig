# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:
let
  nixvim = inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default.extend {
    colorschemes.tokyonight.enable = false;
    colorschemes.nord.enable = true;
  };
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../../shared/laptop
  ];

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
  };

  boot.kernelModules = [
    "i2c-dev"
    "i2c-piix4"
  ];
  boot.kernelPackages = pkgs.linuxPackages_latest;

  services.udev.extraRules = ''
    # Intel AX210 Bluetooth — disable USB autosuspend
    ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="8087", ATTRS{idProduct}=="0032", ATTR{power/autosuspend}="-1"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{address}=="0000:02:00.0", ATTR{power/control}="on"
  '';

  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=0
  '';

  services.udev.packages = [ pkgs.openrgb ];

  systemd.tmpfiles.rules = [
    "w /sys/class/power_supply/BAT1/charge_control_end_threshold - - - - 80"
    "d /etc/asusd 0755 root root"
  ];

  powerManagement.enable = true;

  networking.networkmanager.enable = true;
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.wifi.powersave = false;

  # Enable networking

  hardware.i2c.enable = true;
  hardware.enableAllFirmware = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd start-hyprland";
      };
    };
  };

  security.pam.services.greetd.text = pkgs.lib.mkForce ''
    auth       substack login
    account    include  login
    password   substack login
    session    include  login
  '';

  environment.pathsToLink = [
    "/share/zsh"
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      libvdpau-va-gl
    ];
    enable32Bit = true;
  };

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
    xwayland.enable = true;
  };
  programs.dconf.enable = true;

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  programs.gamescope.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
    NVIDIA_DRIVER_CAPABILITIES = "all";
    WLR_HDR_OUTPUTS = "1";
    NIXOS_OZONE_WL = "1";
    ANDROID_HOME = "$HOME/Android/Sdk";
    #SSH_AUTH_SOCK = "/run/user/1000/gnupg/S.gpg-agent.ssh";
  }; # Force intel-media-driver

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
    #package = config.boot.kernelPackages.nvidiaPackages.latest;
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "595.91.07";
      sha256_64bit = "sha256-yiPIjdJLB6GRZE4eEc+3vN11NzBXSa9A+YABiwleYxM=";
      sha256_aarch64 = "sha256-fqkN7ONFXtTeXyu2mQxorrk362Epxq3bz88hhKYQzwQ=";
      openSha256 = "sha256-OB8Epd+qn/WywxsPiFpxEOAzlJqb6I1SyRoV3a8l71k=";
      settingsSha256 = "sha256-QzT8Cw1luuZGP9DUje3HN/0ngiayqHURj+bqPsxlJ5w=";
      persistencedSha256 = "sha256-3JQBaNmkwxvCXv9q8aHKas6VZM/JjLsuilC2t7ET0u0=";
    };

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:00:0";
      # sync.enable = true;
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.useXkbConfig = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      brlaser
      dcp9020cdwlpr
      dcp9020cdw-cupswrapper
    ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  services.ipp-usb.enable = true;
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
    brscan4 = {
      enable = true;
      netDevices = {
        brother_scanner = {
          model = "DCP-9022CDW";
          ip = "192.168.178.147";
        };
      };
    };
  };
  environment.etc."sane.d/airscan.conf".text = ''
    [devices]
    "Brother DCP-9022CDW" = "http://192.168.178.147:80/WebServices/ScannerService, WSD"
  '';

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonas = {
    isNormalUser = true;
    description = "Jonas";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "adbusers"
      "kvm"
      "scanner"
      "lp"
    ];
    packages = with pkgs; [ ];
  };

  programs.zsh.enable = true;

  programs.yazi = {
    enable = true;
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      intel-vaapi-driver = pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    };
  };

  users.defaultUserShell = pkgs.zsh;

  programs.java.enable = true;

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  virtualisation.docker.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.nix-ld.enable = true;

  services.qbittorrent = {
    enable = false;
    openFirewall = false;
    webuiPort = 8080;
  };

  # system.autoUpgrade.enable = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    gh
    curl
    unstable.spotify
    modrinth-app
    git
    jq
    oh-my-zsh
    zoxide
    usbutils
    fzf
    networkmanagerapplet
    unstable.ghostty
    android-studio
    android-tools
    jetbrains.webstorm
    jetbrains.idea
    unstable.discord
    ripgrep
    fd
    unstable.heroic
    btop
    nvtopPackages.nvidia
    chromium
    python314
    unstable.bun
    unzip
    zip
    ffmpeg
    libreoffice-qt
    prusa-slicer
    signal-desktop
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta
    nixvim
    iperf
    wl-clipboard
    rlwrap
    rsync
    p7zip
    protontricks
    protonplus
    winetricks
    wine
    unstable.antigravity-cli
    nextcloud-client
    hyprpaper
    hypridle
    hyprshot
    hyprsunset
    hyprnotify
    hyprpolkitagent
    brightnessctl
    rofi
    rofi-power-menu
    rofi-bluetooth
    rofi-network-manager
    pavucontrol
    playerctl
    unstable.esptool
    # arduino-ide
    nemo
    zoom-us
    keychain
    cachix
    gimp
    krita
    # rustdesk
    vlc
    anki
    unstable.nixpkgs-review
    (texlive.combine {
      inherit (texlive)
        scheme-full
        ;
    })
    texstudio
    unstable.ausweisapp
    losslesscut-bin
    shotcut
    nixfmt
    brscan4
    noriskclient-launcher
    #unstable.scalable-cli
    unstable.skills
    obsidian
    tldr
    unstable.opencloud-desktop
    bottles
    tor-browser
    inputs.agenix.packages.x86_64-linux.default
  ];

  nixpkgs.config.android_sdk.accept_license = true;

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
  };

  # Virt manager
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "jonas" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  fonts.fontDir.enable = true;
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    fira-code-symbols
    times-newer-roman
    montserrat
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  networking.firewall = {
    enable = false;
    allowedTCPPorts = [
      5173
      3000
      57621
      4242
      24727
    ];
    allowedUDPPorts = [ 57621 ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
