{ pkgs, ... }:

{
  # --- Storage (btrfs on LUKS) ---
  fileSystems = {
    "/".options        = [ "compress=zstd" "noatime" ];
    "/home".options    = [ "compress=zstd" "noatime" ];
    "/nix".options     = [ "compress=zstd" "noatime" ];
    "/var/log".options = [ "compress=zstd" "noatime" ];
    "/var/log".neededForBoot = true;
    "/swap".options    = [ "noatime" ];
  };

  boot.initrd.luks.devices."cryptroot".allowDiscards = true;
  services.fstrim.enable = true;
  services.btrfs.autoScrub.enable = true;

  # --- Swap + hibernation ---
  swapDevices = [ { device = "/swap/swapfile"; } ];
  boot.resumeDevice = "/dev/mapper/cryptroot";
  boot.kernelParams = [ "resume_offset=533760" ];

  # --- GPU: RX 9070 (RDNA4) + Ryzen iGPU ---
  boot.kernelPackages = pkgs.linuxPackages_latest; # Use latest kernel
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}
