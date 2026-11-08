{ pkgs, ... }:

{
  imports = [
    ./zsh.nix
    ./shell-tools.nix
    ./alacritty.nix
    ./tmux.nix
    ./neovim.nix
    ./vscodium.nix
    ./plasma.nix
  ];

  home.username = "vmpyr";
  home.homeDirectory = "/home/vmpyr";
  home.stateVersion = "26.05"; # same as system.stateVersion; never change it

  home.packages = with pkgs; [
    ripgrep
    fd
    btop
    python3

    unstable.claude-code
    unstable.uv
    # unstable.<pkg>
  ];
}
