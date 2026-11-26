# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, inputs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../../shared/laptop
  ];

  age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      theme = inputs.nixos-grub-themes.packages.${pkgs.stdenv.hostPlatform.system}.minegrub;
    };
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "jf-unibook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Security
  security.pam.services.hyprlock = {
    text = ''
      #%PAM-1.0
      auth       sufficient   pam_fprintd.so
      auth       include      login
      account    include      login
      password   include      login
      session    include      login
    '';
    enableGnomeKeyring = true;
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # Enable networking
  networking.networkmanager = {
    enable = true;
    plugins = with pkgs; [
      networkmanager-openconnect
    ];
  };

  virtualisation = {
    containers.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  # Virt manager
  users.groups.libvirtd.members = [ "jonasf" ];

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

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Fingerprint
  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  services.fprintd = {
    enable = true;
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-goodix-550a;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.jonasf = {
    isNormalUser = true;
    description = "Jonas Franke";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [ ];
  };

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    gh
    git
    zoxide
    oh-my-zsh
    curl
    spotify
    fzf
    ripgrep
    unzip
    zip
    fd
    rlwrap
    gcc
    localsend
    unstable.bun
    python3
    fastfetch
    biome
    wl-clipboard
    iperf
    p7zip
    unstable.antigravity-cli
    nextcloud-client
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta
    inputs.nixvim.packages.${pkgs.stdenv.hostPlatform.system}.default
    chromium
    hyprpaper
    hypridle
    hyprnotify
    hyprsunset
    hyprpolkitagent
    rofi
    rofi-power-menu
    rofi-network-manager
    pavucontrol
    playerctl
    brightnessctl
    openconnect
    networkmanagerapplet
    btop
    usbutils
    zoom-us
    discord
    libreoffice-qt
    unstable.jetbrains.idea
    unstable.jetbrains.webstorm
    keychain
    texliveFull
    jdk25_headless
    texstudio
    nemo
    cachix
    nixpkgs-review
    cbonsai
    sl
    openssl
    nodejs_24
    appimage-run
    hyprshot
    acpi
    anki
    ffmpeg
    heroic
    rpi-imager
    krita
    teamtype
    skills
    scribus
    tldr
    vlc
    opencloud-desktop
    gnumake
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    withUWSM = true;
  };

  services.teamviewer.enable = true;

  # Power management
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };
  services.thermald.enable = true;
  services.tlp.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --asterisks -r --cmd start-hyprland";
      };
    };
  };

  security.pam.services.greetd.text = pkgs.lib.mkForce ''
    auth       substack login
    account    include  login
    password   substack login
    session    include  login
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [
      53317
      4242
    ];
    allowedUDPPorts = [ 11101 ];
  };
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
