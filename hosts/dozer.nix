{ config, pkgs, ... }:

{
  imports = [
    ../configuration.nix
    ../hardware/vm-qemu.nix
    ../modules/settings.nix
  ];

  settings = {
    vm = true;
  };

  networking.hostName = "dozer";
}
