{ lib, pkgs, persistence, ... }:
{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./fonts.nix
    ./gtk.nix
    ./playerctl.nix
    ./qt.nix
  ];

  xdg.mimeApps.enable = true;

  programs.mpv.enable = true;

  home.packages = with pkgs; [
    authy
    discord
    imv
    mupdf
    pamixer
    pavucontrol
    piper
    slack
    spotify
    sxiv
    zoom-us
  ];

  home.persistence = lib.mkIf persistence {
    "/persist/home/brenix".directories = [
      ".config/Authy Desktop"
      ".config/Slack"
      ".zoom"
    ];
    "/persist/home/brenix".files = [
      ".config/zoomus.conf"
    ];
  };
}
