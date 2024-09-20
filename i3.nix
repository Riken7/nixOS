{config , pkgs , ...}:
{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager.defaultSession = "none+i3";

    windowManager.i3 = {
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        upower
        alacritty
        rofi #application launche
        i3lock #default i3 screen locker
        polybar
        picom
        feh
        arandr
        xclip
        pulseaudio
        brightnessctl
        xss-lock
        networkmanager
        networkmanagerapplet
      ];
    };
  };
}
