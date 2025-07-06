{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.packages = with pkgs; [
    alacritty
    kitty
    tmux

    starship
    #cli tools
    ttyper
    btop
    dysk
    killall
    fastfetch
    ripgrep
    bat
    curl
  ];
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
    initContent = ''
      export EDITOR=nvim
      eval "$(direnv hook zsh)"
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
