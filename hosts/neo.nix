{ config, lib, ... }:
let
  devices = [
    # GPU
    {
      device = "10de:2206";
      slot = "0b:00.0";
    }
    # GPU AUDIO
    {
      device = "10de:1aef";
      slot = "0b:00.1";
    }
    # I211 Gigabit Ethernet
    {
      device = "8086:1539";
      slot = "06:00.0";
    }
  ];
in {
  boot = {
    kernelParams = [
      "amd_iommu=on"
      "default_hugepagesz=1G"
      "hugepagesz=1G"
      "iommu=pt"
      "mitigations=off"
      "module_blacklist=xhci_pci"
      "nohz_full=8-15,24-31"
      "rcu_nocbs=8-15,24-31"
      "rd.driver.pre=vfio-pci"
      "systemd.unified_cgroup_hierarchy=1"
      "transparent_hugepage=never"
      "tsc=reliable"
      "usbcore.autosuspend=-1"
      "vfio-pci.ids=${lib.concatMapStringsSep "," (d: d.device) devices}"
    ];

    blacklistedKernelModules = [ "nouveau" ];

    kernelModules =
      [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];

    extraModprobeConfig = ''
      options kvm ignore_msrs=1
      options kvm avic=1
    '';
  };

  # Hostname
  networking.hostName = "neo";

  # Enable DHCP
  systemd.network.networks.enp7s0 = {
    matchConfig = { Name = "enp7s0"; };
    DHCP = "yes";
  };

  # DPI settings
  services.xserver.dpi = 109;

  # Fix scaling in GTK apps
  environment.variables.GDK_SCALE = "1";
  environment.variables.GDK_DPI_SCALE = "1";

  # Configure host-specific settings
  settings = {
    dpi = 109;
    fonts = {
      browser.font = "Verdana";
      browser.size = 16;
      launcher.font = "Verdana";
      launcher.size = 10;
      terminal.font = "JetBrains Mono Nerd Font";
      terminal.size = 10.5;
    };
  };

  # Pass settings to home-manager
  home-manager.users.${config.settings.username}.settings = config.settings;

}
