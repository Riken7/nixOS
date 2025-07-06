{inputs, pkgs,... }:
{
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    xwayland.enable = true;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
    };
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;
  environment.systemPackages = with pkgs;[
    greetd.tuigreet
    fish
    python313Packages.aubio
    python313Packages.pyaudio
    python313Packages.numpy
    cava
    bluez-tools
    ddcutil
    imagemagick
    brightnessctl
    ibm-plex
    material-symbols
    fd
    hyprshot
  ];

#  environment.sessionVariables = {
#    WLR_NO_HARDWARE_CURSORS = "1";
#    LIBVA_DRIVER_NAME = "nvidia";
#    VDPAU_DRIVER = "nvidia";
#    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; 
#    WLR_DRM_DEVICES = "/dev/dri/card0";
#  };

  }
