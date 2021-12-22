{ config, pkgs, ... }: {

  imports = [ ../hardware/vm-fusion.nix ];

  # Hostname
  networking.hostName = "tank";

  # DPI settings
  services.xserver.dpi = 180;
  hardware.video.hidpi.enable = true;

  # Fix alacritty font scaling on hidpi
  environment.variables.WINIT_X11_SCALE_FACTOR = "1.5";

  # Fix scaling in GTK apps
  environment.variables.GDK_SCALE = "2";
  environment.variables.GDK_DPI_SCALE = "0.5";

  # Enable touchpad
  services.xserver.libinput.enable = true;

  # Configure host-specific settings
  settings = {
    dpi = 180;
    monitor = "Virtual1";
    fonts = {
      browser.font = "Verdana";
      browser.size = 16;
      launcher.font = "Verdana";
      launcher.size = 10;
      terminal.font = "JetBrains Mono Nerd Font";
      terminal.size = 12.5;
    };
  };

  # Pass settings to home-manager
  home-manager.users.${config.settings.username}.settings = config.settings;
}
