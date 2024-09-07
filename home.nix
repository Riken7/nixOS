{config , pkgs , ...}:
{
	home.username = "rik";
	home.homeDirectory = "/home/rik";

	home.packages = with pkgs; [
		htop
    gnome-terminal 
		#jetbrains.idea-community-src
	];

	home.stateVersion = "24.05";

	programs.home-manager.enable = true;
	programs.neovim.enable = true;
}
