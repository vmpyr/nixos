{ config, ... }:

{
  programs.alacritty = {
    enable = true;
    theme = "tomorrow_night_bright";

    settings = {
      font = {
        normal.family = "MesloLGS Nerd Font";
        size = 12;
      };

      window = {
        opacity = 0.95;
        startup_mode = "Maximized";
        decorations = "None"; # no title bar
      };

      keyboard.bindings = [
        {
          key = "V";
          mods = "Control";
          action = "Paste";
        }
      ];

      # Always land in tmux: attach to the `main` session, or create it.
      # Closing the window only detaches; the session keeps running.
      terminal.shell = {
        program = "${config.programs.tmux.package}/bin/tmux";
        args = [
          "new-session"
          "-A"
          "-s"
          "main"
        ];
      };
    };
  };
}
