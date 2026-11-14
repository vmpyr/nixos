{ pkgs, inputs, ... }:

let
  # GameSir controller configurator; also ships 70-gamesir.rules (hidraw uaccess)
  deadband = inputs.deadband.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  services.udev.packages = [ deadband ];

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
    pkgs.unstable.eden # Switch emulator
    pkgs.mangohud
    deadband
    (pkgs.unstable.heroic.override {
      extraPkgs = p: [
        p.mangohud
        p.gamemode
      ];
    })
  ];
}
