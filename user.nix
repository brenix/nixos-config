{ config, pkgs, inputs, system, ... }: {

  imports = [
    ./home/alacritty
    ./home/dunst
    ./home/firefox
    ./home/git
    ./home/neovim
    ./home/openbox
    ./home/polybar
    ./home/rofi
    ./home/starship
    ./home/tmux
    ./home/zsh
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # X11
  xsession = {
    enable = true;
    pointerCursor = {
      package = pkgs.capitaine-cursors;
      name = "capitaine-cursors-white";
    };
    windowManager = { command = "openbox-session"; };
  };

  # XDG
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      documents = "$HOME/downloads/documents/";
      download = "$HOME/downloads/";
      videos = "$HOME/downloads/videos/";
      music = "$HOME/downloads/music/";
      pictures = "$HOME/downloads/pictures/";
      desktop = "$HOME/downloads/desktop/";
      publicShare = "$HOME/downloads/public/";
      templates = "$HOME/downloads/templates/";
    };
  };

  # Packages to be installed
  home.packages = with pkgs; [
    authy
    awless
    aws-vault
    awscli
    buildah
    chamber
    cosign
    dconf # gtk dep
    discord
    feh
    fluxcd
    gomplate
    googler
    goreleaser
    grc
    guvcview
    handlr
    helmfile
    hugo
    kubectl
    kubernetes-helm
    kustomize
    lab
    lefthook
    lxappearance
    mr
    mupdf
    nodePackages.npm
    nodejs
    openrgb
    packer
    pavucontrol
    pcmanfm
    pgcli
    pipenv
    ranger
    sd
    slack
    sops
    spotify
    stern
    sxiv
    terraform
    theme-vertex
    unrar
    unzip
    vault-bin
    velero
    virt-manager
    win-virtio
    xclip
    zoom-us
  ];

  # Autocutsel
  systemd.user.services.autocutsel = {
    Unit.Description = "AutoCutSel";
    Install = { WantedBy = [ "default.target" ]; };
    Service = {
      Type = "forking";
      Restart = "always";
      RestartSec = 2;
      ExecStartPre = "${pkgs.autocutsel}/bin/autocutsel -fork";
      ExecStart = "${pkgs.autocutsel}/bin/autocutsel -selection PRIMARY -fork";
    };
  };

  # bat
  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
      pager = "less -inMRF";
    };
  };

  # dircolors
  programs.dircolors.enable = true;

  # fzf
  programs.fzf = {
    enable = true;
    defaultOptions = [
      # nord colorscheme
      "--color=fg:#e5e9f0,bg:#191c26,hl:#a3be8b"
      "--color=fg+:#e5e9f0,bg+:#191c26,hl+:#a3be8b"
      "--color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac"
      "--color=marker:#81a1c1,spinner:#b48dac,header:#81a1c1"
    ];
  };

  # go
  programs.go = {
    enable = true;
    goPath = "go";
  };

  # GTK
  gtk = {
    enable = true;
    font = {
      package = pkgs.corefonts;
      name = "Verdana";
      size = 10;
    };
    iconTheme = {
      package = pkgs.arc-icon-theme;
      name = "Arc";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc";
    };
  };

  # GPG
  programs.gpg = { enable = true; };

  services.gpg-agent.enable = true;

  # htop
  programs.htop = {
    enable = true;
    settings = {
      sort_direction = true;
      sort_key = "PERCENT_CPU";
    };
  };

  # flameshot
  services.flameshot = {
    enable = true;
    settings = {
      General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
      };
    };
  };

  # jq
  programs.jq.enable = true;

  # disable man pages
  programs.man.enable = false;

  # mpv
  programs.mpv.enable = true;

  # playerctl
  services.playerctld.enable = true;

  # unclutter
  services.unclutter.enable = true;

  # ssh
  programs.ssh = {
    enable = true;
    includes = [ "~/.ssh/cells/config/*" ];
  };

  # terraform
  # TODO: fix hardcoded username
  home.file.".terraformrc".text = ''
    plugin_cache_dir = "/home/brenix/.cache/terraform-plugin-cache"
    disable_checkpoint = true
  '';
  systemd.user.tmpfiles.rules =
    [ "d /home/brenix/.cache/terraform-plugin-cache 0755 brenix users" ];

}
