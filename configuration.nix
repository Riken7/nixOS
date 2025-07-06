{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    #./nvidia.nix
    ./services
    ./system
    ./modules/filemanager.nix
    #./config/touchpad/touchpad_config.nix
    ./scripts
  ];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      ibm-plex
      material-symbols
      nerd-fonts.jetbrains-mono
    ];
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  environment.systemPackages = with pkgs; [
    firefox
    sops
    sshfs
    alacritty
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
    #mysql84
    #mysql-workbench

    bun

    #npm
    nodePackages_latest.pnpm
    nodePackages_latest.vercel
    nodePackages_latest.prisma
    openssl
    nodejs_24
    postgresql_17

    #themes
    whitesur-icon-theme
  ];
  environment.variables.PRISMA_QUERY_ENGINE_LIBRARY = "${pkgs.prisma-engines}/lib/libquery_engine.node";
  environment.variables.PRISMA_QUERY_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/query-engine";
  environment.variables.PRISMA_SCHEMA_ENGINE_BINARY = "${pkgs.prisma-engines}/bin/schema-engine";
  #services.mysql.enable = true;
  #services.mysql.package = pkgs.mysql84;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "i2c_hid" "i2c_hid_acpi"];

  boot.blacklistedKernelModules = [
    "nouveau"
  ];
  boot.kernelParams = [
    "acpi.power_nocheck=1"
    "acpi_osi=linux"
  ];

  networking.networkmanager.enable = true;
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

  services.printing.enable = false;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false; # power up bt on boot
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  # Defining power up command after suspend
  #powerManagement.powerUpCommands = "sudo rmmod atkbd; sudo modprobe atkbd reset=1";
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
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  #services.openssh.enable = true;
  #services.openssh.permitRootLogin = "no";
  #services.openssh.passwordAuthentication = true;
  # Open ports in the firewall.
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall.allowedTCPPorts = [ 4389 ];

  system.stateVersion = "24.05"; # Did you read the comment?
  programs.nix-ld.enable = true;

  programs.fuse.userAllowOther = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };


#  sops = {
#    age.keyFile = "/home/rik/.config/sops/age/keys.txt";
#  };
#  sops.secrets.address = {
#    sopsFile = "./secrets/secrets.yaml";
#    owner = "rik";
#  };
}
