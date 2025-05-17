{ config, pkgs, ... }:
{
  home.username = "rik";
  home.homeDirectory = "/home/rik";

  home.packages = with pkgs; [
    obs-studio
    obs-studio-plugins.input-overlay
    figma-linux
    kitty
    screenkey
    davinci-resolve
    xcape
    flameshot
    php
    gparted

    dysk #df alternative

    zenity
    jq

    discord
    usermount # auto-mounting of usb drives
    onlyoffice-bin
    ttyper
    tmux
    file-roller
    stremio
    rclone
    btop
    nix-index

    #oh-my-posh
    starship

    ripgrep
    python311
    rustc
    bat
    ##formatters
    prettierd
    black
    isort
    rustfmt
    luaformatter
    nixfmt-rfc-style
    google-java-format
    clang-tools
    ##lsps
    vscode-langservers-extracted
    ccls
    jdt-language-server
    lua-language-server
    rust-analyzer
    pyright
    tailwindcss-language-server
    typescript-language-server
    nixd
    ##linters
    ktlint
    luajitPackages.luacheck
    checkstyle
    pylint
    eslint_d
    cppcheck

    alacritty
    rofi
  ];
  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      jdt-language-server
      rust-analyzer
      lua-language-server
      pyright
      tailwindcss-language-server
      typescript-language-server
      nixd
    ];
  };
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    #initExtraFirst = ''
    #  eval "$(oh-my-posh init zsh --config ~/.dotfiles/config/oh-my-posh-theme.json)"
    #'';
    initExtra = ''
      export EDITOR=nvim
      eval "$(direnv hook zsh)"
      export GTK_THEME=WhiteSur:dark
      export STARSHIP_CONFIG="$HOME/.dotfiles/config/starship.toml"
    '';
    shellAliases = {
      cat = "bat";
      ll = "ls -l";
      update = "cd ~/.dotfiles ; ./autocommit.sh";
      nupdate = "cd ~/.dotfiles ; sudo nixos-rebuild switch --flake .";
      fixit = "sudo modprobe -r i2c_hid_acpi && sudo modprobe i2c_hid_acpi";
      #open = "xdg-open"; #gnome
      open = "thunar"; # i3
      onedrive = "rclone --vfs-cache-mode writes mount 'onedrive': ~/onedrive";
      conf = "nvim ~/.dotfiles/configuration.nix";
      homeconf = "nvim ~/.dotfiles/home.nix";
      gst = "git status";
      gp = "git push";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
}
