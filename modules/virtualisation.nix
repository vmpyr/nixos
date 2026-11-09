{
  # --- VMs: QEMU/KVM via libvirt, managed with virt-manager (GUI) ---
  # Used for the Ubuntu 26.04 work VM (Debian/Ubuntu packaging).
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true; # pass USB devices (stick, YubiKey) into a VM

  users.users.vmpyr.extraGroups = [ "libvirtd" ]; # manage system VMs without sudo

  # VM disk images on btrfs fragment badly with copy-on-write; disable it (+C) for the
  # images directory. Only affects files created after the attribute is set.
  systemd.tmpfiles.rules = [
    "d /var/lib/libvirt/images 0711 root root -"
    "h /var/lib/libvirt/images - - - - +C"
  ];

  # Make virt-manager connect to the system libvirt (qemu:///system) automatically
  home-manager.users.vmpyr.dconf.settings."org/virt-manager/virt-manager/connections" = {
    autoconnect = [ "qemu:///system" ];
    uris = [ "qemu:///system" ];
  };
}
