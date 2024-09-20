{config , pkgs , ...}:
{
  services.xserver = {
    enable = true;
    windowManager.i3.enable = true;
    displayManager.defaultSession = "none+i3";

    windowManager.i3 = {
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        maim #screenshot tool
        xfce.thunar #file manager
        upower #power management
        autotiling #auto tiling
        alacritty #terminal
        rofi #application launche
        i3lock #default i3 screen locker
        polybar #status bar
        picom #compositor
        feh #wallpaper
        arandr #screen layout
        xclip #clipboard
        pulseaudio 
        brightnessctl
        xss-lock #screen locker
      ];
    };
  };
}
