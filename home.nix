{config , pkgs , ...}:
{
	home.username = "rik";
	home.homeDirectory = "/home/rik";

	home.packages = with pkgs; [
		htop
    gnome-terminal 
    rofi
    picom
    feh
    arandr
		#jetbrains.idea-community-src
	];

	home.stateVersion = "24.05";

	programs.home-manager.enable = true;
	programs.neovim.enable = true;
  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake .";
        open = "xdg-open";
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
