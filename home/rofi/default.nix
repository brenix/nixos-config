{ pkgs, ... }: {

  imports = [
    ../../modules/settings.nix
  ];

  programs.rofi = {
    enable = true;
    font = "Verdana 10";
    theme = "Arc";
    plugins = with pkgs; [
      rofi-calc
    ];
  };

}
