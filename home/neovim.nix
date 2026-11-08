{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true; # sets EDITOR=nvim
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      vim-tmux-navigator
    ];
  };
}
