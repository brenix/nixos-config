{ pkgs, ... }:
{
  imports = [
    ./foot.nix
    ./mako.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    mimeo
    slurp
    wf-recorder
    wl-clipboard
    wlr-randr
    ydotool
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = true;
    QT_QPA_PLATFORM = "wayland";
    LIBSEAT_BACKEND = "logind";
  };
}
