{ pkgs, ... }:

{
  # --- Tailscale ---
  services.tailscale = {
    enable = true; # tailscaled daemon + `tailscale` CLI
    useRoutingFeatures = "client"; # allows using exit nodes / subnet routes advertised by others
  };

  environment.systemPackages = with pkgs; [
    ktailctl
  ];
}
