# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    #./nvidia.nix
    ./services/logind.nix
    ./services/greetd.nix
    ./services/powerManagement.nix
    ./modules/filemanager.nix
    #./config/touchpad/touchpad_config.nix
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  #swapfile
  #swapDevices = [{
  #	device = "/swapfile";
  #}];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.blacklistedKernelModules = [
    "psmouse"
    "i2c_hid_acpi"
  ];
  # Enable networking
  networking.networkmanager.enable = true;
  #enabling zsh for rik 
  programs.zsh.enable = true;
  users.users.rik.shell = pkgs.zsh;
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.libinput.enable = true;
  services.libinput.touchpad = {
    disableWhileTyping = true;
    accelSpeed = "0.4";
    tapping = false;
    naturalScrolling = false;
    middleEmulation = false;
    tappingButtonMap = "lrm";
  };
  # Enable CUPS to print documents.
  services.printing.enable = false;

  # Bluetooth => setup bluetooth + enabled experimental features
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # power up bt on boot
  #hardware.pulseaudio = {
  #       enable = true;
  #       package = pkgs.pulseaudioFull;
  # };
  #   hardware.bluetooth.settings = {
  #         General = {
  #           Experiment = true;
  #           Enable = "Source,Sink,Media,Socket";
  #         };
  #   };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  # Defining power up command after suspend
  powerManagement.powerUpCommands = "sudo rmmod atkbd; sudo modprobe atkbd reset=1";
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rik = {
    isNormalUser = true;
    description = "Riken";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #docker 
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  #setting up root directory for docker data
  virtualisation.docker.daemon.settings = {
    data-root = "/home/rik/.docker_data";
  };
  environment.systemPackages = with pkgs; [
    prisma-engines
    chromium
    nerd-fonts.jetbrains-mono

    greetd.tuigreet
    wl-clipboard
    home-manager
    vim
    direnv
    jdk
    gcc
    nasm
    brave
    gh
    git
    postman
    pavucontrol
    superfile
    appimage-run
    mysql84
    mysql-workbench

    bun

    #npm 
    nodePackages_latest.pnpm
    nodePackages_latest.vercel
    nodePackages_latest.prisma
    openssl
    nodejs_24
    postgresql_17
  ];
  environment.variables.PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
  environment.variables.PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
  environment.variables.PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql84;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;
  #services.openssh.permitRootLogin = "no";
  #services.openssh.passwordAuthentication = true;
  # Open ports in the firewall.
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?
  programs.nix-ld.enable = true;

  programs.fuse.userAllowOther = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
