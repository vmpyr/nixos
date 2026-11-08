{ pkgs, ... }:

{
  programs.gpg.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-qt; # Plasma password popup
    defaultCacheTtl = 3600; # remember passphrase for 1h after last use
  };
}
