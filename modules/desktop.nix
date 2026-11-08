{
  # --- Desktop: KDE Plasma 6 on Wayland ---
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "plasma";

  # --- Audio: PipeWire ---
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- Extras ---
  hardware.bluetooth.enable = true;
  services.printing.enable = true;

  # --- Device sharing ---
  programs.kdeconnect.enable = true; # phone integration; opens TCP/UDP 1714-1764
  programs.localsend.enable = true; # AirDrop-style file transfer; opens port 53317
}
