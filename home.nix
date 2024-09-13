{config , pkgs , ...}:
{
	home.username = "rik";
	home.homeDirectory = "/home/rik";

	home.packages = with pkgs; [
    tmux
    stremio
    rclone
    awscli
		htop
    gnome-terminal
    nix-index
    vscode-fhs
  #i3 related pkgs ->
    #rofi
    #picom
    #feh
    #arandr

		#jetbrains.idea-community-src
	];

	home.stateVersion = "24.05";

	programs.home-manager.enable = true;
	programs.neovim = {
    enable = true;
  };
#  programs.nixvim = {
#    enable = true;
#  };
  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      shellAliases = {
        ll = "ls -l";
        update = "cd ~/.dotfiles ; sudo nixos-rebuild switch --flake .";
        open = "xdg-open";
        onedrive = "rclone --vfs-cache-mode writes mount 'onedrive': ~/onedrive";
        conf = "nvim ~/.dotfiles/configuration.nix";
        homeconf =  "nvim ~/.dotfiles/home.nix";
      };
      history = {
        size = 10000;
        path = "${config.xdg.dataHome}/zsh/history";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "direnv"];
        theme = "robbyrussell";
      };
  };
}
