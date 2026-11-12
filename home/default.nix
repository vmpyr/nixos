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
    ./git.nix
    ./gpg.nix
    ./ssh.nix
  ];

  home.username = "vmpyr";
  home.homeDirectory = "/home/vmpyr";
  home.stateVersion = "26.05"; # same as system.stateVersion; never change it

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    btop
    tig
    python3
    qbittorrent
    helium
    jellyfin-desktop

    unstable.claude-code
    unstable.uv
    unstable.vesktop
    unstable.supersonic
    unstable.vlc
    # unstable.<pkg>
  ];
}
