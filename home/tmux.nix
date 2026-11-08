{ pkgs, ... }:

{
  home.packages = [ pkgs.wl-clipboard ]; # wl-copy, used by tmux-yank

  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1; # windows and panes start at 1
    historyLimit = 50000;
    escapeTime = 0; # no delay after Esc (important in neovim)
    terminal = "tmux-256color";

    # Plugins are pinned via nixpkgs (no TPM). Each plugin's extraConfig is
    # placed right before the plugin is loaded.
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator # Ctrl-h/j/k/l across tmux panes and nvim splits; prefix C-l clears screen
      {
        plugin = catppuccin;
        extraConfig = ''
          # Show only window numbers in the status bar (catppuccin v2 options)
          set -g @catppuccin_window_status_style "custom"
          set -g @catppuccin_window_left_separator " "
          set -g @catppuccin_window_middle_separator " "
          set -g @catppuccin_window_right_separator ""
          set -g @catppuccin_window_text ""
          set -g @catppuccin_window_current_text ""
        '';
      }
      {
        plugin = yank;
        extraConfig = ''
          set -g @override_copy_command 'wl-copy'
          set -g @yank_selection 'clipboard'
          set -g @yank_selection_mouse 'clipboard'
          set -g @yank_action 'copy-pipe' # stay in copy mode after yanking
        '';
      }
    ];

    extraConfig = ''
      # Truecolor + hyperlinks from alacritty
      set -ga terminal-features ",alacritty:RGB"
      set -ga terminal-features "*:hyperlinks"

      # Propagate Wayland display socket to tmux environment
      set -ga update-environment "WAYLAND_DISPLAY"

      # Shift+Alt window switching
      bind -n M-H previous-window
      bind -n M-L next-window

      set -g renumber-windows on
      set -g automatic-rename off
      set -g allow-rename off

      # Open splits in the current directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };
}
