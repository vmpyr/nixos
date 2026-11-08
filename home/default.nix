{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./vscodium.nix
  ];

  home.username = "vmpyr";
  home.homeDirectory = "/home/vmpyr";
  home.stateVersion = "26.05"; # same as system.stateVersion; never change it

  home.packages = with pkgs; [
    ripgrep
    fd
    btop

    unstable.claude-code
    # unstable.<pkg>
  ];
}
