{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./system/nvim.nix
    ./modules/terminal.nix
  ];
  home.username = "rik";
  home.homeDirectory = "/home/rik";

  home.packages = with pkgs; [
    youtube-music
    obs-studio
    obs-studio-plugins.input-overlay
    figma-linux
    termusic

    screenkey

    zenity
    jq
    lm_sensors

    discord
    vesktop
    stremio
    rclone
    nix-index

    #oh-my-posh
    python311
    rustc
    gtk3
    #inputs.zen-browser.packages.${system}.default
  ];
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
