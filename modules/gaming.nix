{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
    extraPackages = [ pkgs.mangohud ];
  };
  programs.gamemode.enable = true;

  environment.systemPackages = [
    pkgs.unstable.r2modman # Thunderstore mod manager
    pkgs.mangohud
    (pkgs.unstable.heroic.override {
      extraPkgs = p: [
        p.mangohud
        p.gamemode
      ];
    })
  ];
}
