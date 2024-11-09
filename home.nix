{ config, pkgs, ... }:
{
  home.username = "rik";
  home.homeDirectory = "/home/rik";

  home.packages = with pkgs; [
    discord
    usermount # auto-mounting of usb drives
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
    oh-my-posh
    ripgrep
    python311
    rustc

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
    ccls
    jdt-language-server
    lua-language-server
    rust-analyzer-unwrapped
    pyright
    tailwindcss-language-server
    typescript-language-server
    nixd
    ##linters
    #clippy
    luajitPackages.luacheck
    checkstyle
    pylint
    eslint_d
    cppcheck
  ];

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      jdt-language-server
      rustc
      lua-language-server
      pyright
      tailwindcss-language-server
      typescript-language-server
      nixd
    ];
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "cd ~/.dotfiles ; ./autocommit.sh";
      nupdate = "cd ~/.dotfiles ; sudo nixos-rebuild switch --flake .";
      #open = "xdg-open"; #gnome
      open = "thunar"; # i3
      onedrive = "rclone --vfs-cache-mode writes mount 'onedrive': ~/onedrive";
      conf = "nvim ~/.dotfiles/configuration.nix";
      homeconf = "nvim ~/.dotfiles/home.nix";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "direnv"
      ];
      # theme = "robbyrussell";
    };
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    useTheme = "jblab_2021";
    settings = builtins.fromJSON (
      builtins.unsafeDiscardStringContext ''
        {
          "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
          "version": 2,
          "final_space": true,
          "console_title_template": "{{if .Root}} ⚡ {{end}}{{.Folder | replace \"~\" \"🏠\"}} @ {{.HostName}}",
          "blocks": [
            {
              "type": "prompt",
              "alignment": "left",
              "segments": [
                {
                  "type": "os",
                  "style": "diamond",
                  "leading_diamond": "\ue0b6",
                  "trailing_diamond": "\ue0b0",
                  "template": " {{ .Icon }} ",
                  "background": "#0C212F",
                  "foreground": "#FFFFFF"
                },
                {
                  "type": "root",
                  "style": "diamond",
                  "leading_diamond": "<transparent,#DE2121>\ue0b0</>",
                  "trailing_diamond": "\ue0b0",
                  "template": " \uf0e7 ",
                  "background": "#DE2121",
                  "foreground": "#FFFFFF"
                },
                {
                  "type": "path",
                  "style": "diamond",
                  "leading_diamond": "<transparent,#26BDBB>\ue0b0</>",
                  "trailing_diamond": "\ue0b0",
                  "template": " {{ .Path }} ",
                  "properties": {
                    "folder_icon": "...",
                    "folder_separator_icon": "<transparent> \ue0b1 </>",
                    "home_icon": "\ueb06",
                    "style": "agnoster_short"
                  },
                  "background": "#26BDBB",
                  "foreground": "#0C212F"
                }
              ]
            },
            {
              "type": "prompt",
              "alignment": "right",
              "segments" : [
                {
                  "type": "status",
                  "style": "diamond",
                  "leading_diamond": "<transparent,background>\ue0b0</>",
                  "trailing_diamond": "\ue0b0",
                  "template": "<transparent> \uf12a</> {{ reason .Code }} ",
                  "background": "#910000",
                  "foreground": "#ffffff"
                },
                {
                  "type": "git",
                  "style": "powerline",
                  "powerline_symbol": "\ue0b0",
                  "background_templates": [
                    "{{ if or (.Working.Changed) (.Staging.Changed) }}#7621DE{{ end }}",
                    "{{ if and (gt .Ahead 0) (gt .Behind 0) }}#7621DE{{ end }}",
                    "{{ if gt .Ahead 0 }}#7621DE{{ end }}",
                    "{{ if gt .Behind 0 }}#7621DE{{ end }}"
                  ],
                  "template": " {{ .UpstreamIcon }}{{ .HEAD }}{{ if .Staging.Changed }} \uf046 {{ .Staging.String }}{{ end }}{{ if and (.Working.Changed) (.Staging.Changed) }} |{{ end }}{{ if .Working.Changed }} \uf044 {{ .Working.String }}{{ end }}{{ if gt .StashCount 0 }} \ueb4b {{ .StashCount }}{{ end }} ",
                  "properties": {
                    "fetch_stash_count": true,
                    "fetch_status": true,
                    "fetch_upstream_icon": true
                  },
                  "background": "#280C2E",
                  "foreground": "#FFFFFF"
                }
              ]
            }
          ]
        }
      ''
    );
  };
}
