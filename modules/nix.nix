{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [ "vmpyr" ]; # allows extra binary caches (cachix etc.) without root
    warn-dirty = false; # silence "Git tree is dirty" (the prompt already shows uncommitted changes)
  };

  # --- Housekeeping ---
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # --- Run unpatched binaries ---
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      zlib
    ];
  };
}
