{ lib, ... }:

with lib; {
  options = {
    settings = {
      name = mkOption {
        default = "Paul Nicholson";
        type = with types; uniq str;
      };
      username = mkOption {
        default = "brenix";
        type = with types; uniq str;
      };
      email = mkOption {
        default = "brenix@gmail.com";
        type = with types; uniq str;
      };
      browser = mkOption {
        default = "firefox";
        type = with types; uniq str;
      };
      terminal = mkOption {
        default = "alacritty";
        type = with types; uniq str;
      };
      fontName = mkOption {
        default = "JetBrainsMono Nerd Font";
        type = with types; uniq str;
      };
      fontSize = mkOption {
        default = 10.5;
        type = types.float;
      };
      monitor = mkOption {
        default = "Virtual-1";
        type = with types; uniq str;
      };
    };
  };
}
