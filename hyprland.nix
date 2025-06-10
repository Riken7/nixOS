{ pkgs,... }:
{

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    portalPackage = pkgs.portal;
    };
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    VDPAU_DRIVER = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; 
    WLR_DRM_DEVICES = "/dev/dri/card0";
  };

  }
