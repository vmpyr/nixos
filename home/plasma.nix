{
  # Only settings declared here are managed; everything else in Plasma stays as-is.
  programs.plasma = {
    enable = true;

    hotkeys.commands.alacritty = {
      name = "Launch Alacritty";
      key = "Meta+Return";
      command = "alacritty";
    };

    shortcuts = {
      kwin."Window Close" = [
        "Meta+Q"
        "Alt+F4"
      ];
      plasmashell."manage activities" = [ ];
    };
  };
}
