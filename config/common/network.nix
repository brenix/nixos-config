{ lib, ... }: {
  # Disable firewall
  networking.firewall.enable = false;

  # Enable systemd-resolved
  services.resolved.enable = lib.mkDefault true;

  # Enable systemd-networkd
  networking.dhcpcd.enable = false;
  systemd.network.enable = true;

  # Disable DNSSEC (for now)
  services.resolved.dnssec = "false";
}
