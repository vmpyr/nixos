{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./hardware.nix
    ../../modules
  ];

  # --- Boot ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  # --- Network ---
  networking.hostName = "aragorn";
  networking.networkmanager.enable = true;

  # --- Locale ---
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # --- Packages ---
  nixpkgs.config.allowUnfree = true;
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    unzip
  ];

  system.stateVersion = "26.05";
}
