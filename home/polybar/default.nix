{ config, pkgs, ... }: {

  imports = [ ../../modules/settings.nix ];

  services.polybar = {
    enable = true;

    package = pkgs.polybarFull;

    script = "";

    settings = let colors = config.colorscheme.colors;
    in {
      "settings" = {
        screenchange-reload = true;
        format-padding = 0.5;
      };

      "colors" = {
        bg = "#${colors.base00}";
        bg-alt = "#${colors.base00}";
        fg = "#${colors.base06}";
        fg-alt = "#${colors.base05}";
        blue = "#${colors.base0D}";
        cyan = "#${colors.base0C}";
        green = "#${colors.base0B}";
        orange = "#${colors.base09}";
        purple = "#${colors.base0F}";
        red = "#${colors.base08}";
        yellow = "#${colors.base0A}";
      };

      "bar/main" = {
        top = true;
        height = 22;
        dpi = config.settings.dpi;
        monitor = config.settings.monitor;
        enable-ipc = true;
        width = "100%";
        foreground = "\${colors.fg}";
        background = "\${colors.bg}";
        border-bottom-color = "\${colors.bg}";
        border-bottom-size = 1;
        border-top-color = "\${colors.bg}";
        border-top-size = 1;
        font-0 = "Verdana:size=9;2";
        font-1 = ''"Material Icons:size=9;3"'';
        font-2 = ''"JetBrainsMono Nerd Font Mono:size=14;3"'';
        module-margin-left = 1;
        module-margin-right = 1;
        modules-left = "workspaces";
        modules-center = "now-playing";
        modules-right = "battery cpu temperature memory volume date time";
        offset-x = 0;
        offset-y = 0;
        padding-left = 1;
        padding-right = 1;
      };

      "module/now-playing" = {
        type = "custom/script";
        tail = true;
        format = "<label>";
        exec = "${config.xdg.configHome}/polybar/scripts/polybar-now-playing";
        click-right = "kill -USR1 $(pgrep --oldest --parent %pid%)";
      };

      "module/battery" = {
        type = "internal/battery";
        battery = "BAT1";
        adapter = "ACAD";
        format-discharging = " <label-discharging>";
        format-charging = " <label-charging>";
        format-full = " <label-full>";
        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "%percentage%%";
        # ramp-capacity-0 = "";
        # ramp-capacity-1 = "";
        # ramp-capacity-2 = "";
        # ramp-capacity-3 = "";
        # ramp-capacity-4 = "";
        poll-interval = 10;
      };

      "module/workspaces" = {
        type = "internal/bspwm";
        enable-click = true;
        enable-scroll = true;
        pin-workspaces = false;
        format = "<label-state>";
        format-padding = 0;
        label-empty = "%icon%";
        label-empty-padding = 1;
        label-focused = "%icon%";
        label-focused-foreground = "\${colors.blue}";
        label-focused-padding = 1;
        label-occupied = "%icon%";
        label-occupied-padding = 1;
        label-urgent = "%icon%";
        label-urgent-padding = 1;
        ws-icon-0 = "1;";
        ws-icon-1 = "2;";
        ws-icon-2 = "3;";
        ws-icon-3 = "4;";
        ws-icon-default = "";
      };

      "module/temperature" = {
        type = "internal/temperature";
        interval = 3;
        hwmon-path = "\${env:HWMON_PATH}";
        thermal-zone = 0;
        base-temperature = 20;
        warn-temperature = 60;
        label = "%temperature-c%";
        label-warn = "%temperature-c%";
        label-warn-foreground = "\${colors.red}";
        format = "<label>";
        format-prefix = " ";
        format-warn = "<label-warn>";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 3;
        label = "%percentage:2%%";
        format-prefix = " ";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 30;
        label = "%gb_used%";
        format-prefix = " ";
      };

      "module/volume" = {
        type = "internal/pulseaudio";
        use-ui-max = false;
        interval = 2;
        bar-volume-empty-foreground = "\${colors.fg-alt}";
        format-volume = "<ramp-volume> <label-volume>";
        label-muted = " %{F#b77a76}MUTED";
        label-muted-foreground = "\${colors.fg-alt}";
        label-volume =
          "%{A3:${pkgs.pavucontrol}/bin/pavucontrol & disown:}%percentage%%%{A}";
        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
      };

      "module/time" = {
        type = "internal/date";
        interval = 5;
        time = "%r";
        label = "%time%";
        format-prefix = " ";
      };

      "module/date" = {
        type = "internal/date";
        interval = 3600;
        date = "%Y-%m-%d";
        label =
          "%{A1:${pkgs.gsimplecal}/bin/gsimplecal & disown:}%{A3:${pkgs.gsimplecal}/bin/gsimplecal & disown:} %date%%{A}%{A}";
      };
    };
  };

  xdg.configFile."polybar/scripts" = {
    source = ./scripts;
    recursive = true;
  };
}

