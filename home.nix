{config , pkgs , ...}:
{

	home.username = "rik";
	home.homeDirectory = "/home/rik";
  
	home.packages = with pkgs; [
    clementine
    discord
    usermount #auto-mounting of usb drives
    onlyoffice-bin
    ttyper
    tmux
    file-roller
    stremio
    rclone
    awscli
		btop
    nix-index
    vscode-fhs
    #gnome-terminal
    ripgrep
    python311
    prettierd
    black
    isort
    rustfmt
    stylua
    ##linters
    #eslint_d
    #luajitPackages.luacheck
    #splint
    #checkstyle
    #python311Packages.flake8
		#jetbrains.idea-community-src
];

	home.stateVersion = "24.05";

	programs.home-manager.enable = true;
	programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      jdt-language-server
      lua-language-server
      rust-analyzer
      ccls
      pyright
      tailwindcss-language-server
      typescript-language-server
    ];
  };

  programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      #initExtra = "fastfetch";
      shellAliases = {
        ll = "ls -l";
        update = "cd ~/.dotfiles ; ./autocommit.sh";
        #open = "xdg-open"; #gnome
        open = "thunar"; #i3
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
