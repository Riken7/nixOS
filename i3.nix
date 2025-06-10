{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver = {
    displayManager.lightdm.enable = true;
    windowManager.i3 = {
      enable = true;
      configFile = "/home/rik/.dotfiles/config/i3/config";
    };
    windowManager.i3 = {
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        libnotify # notifications
        dunst # notification deamon
        xfce.thunar # file manager
        upower # power management
        autotiling # auto tiling
        alacritty # terminal
        rofi # application launche
        i3lock-color
        polybar # status bar
        picom # compositor
        feh # wallpaper
        arandr # screen layout
        xclip # clipboard
        brightnessctl
      ];
    };
  };
}
