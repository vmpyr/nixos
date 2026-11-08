{ pkgs, ... }:

{
  programs.vscodium = {
    enable = true;
    package = pkgs.unstable.vscodium;

    profiles.default.extensions = [
      pkgs.vscode-extensions.jnoortheen.nix-ide
    ];
  };
}
