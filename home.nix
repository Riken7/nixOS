{config , pkgs , ...}:
{
	home.username = "rik";
	home.homeDirectory = "/home/rik";

	home.packages = with pkgs; [
		htop
	];

	home.stateVersion = "24.05";

	programs.home-manager.enable = true;

}
