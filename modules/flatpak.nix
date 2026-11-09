{
  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    # Declaratively managed apps (Flathub IDs), e.g. "com.gopeed.Gopeed"
    packages = [ ];

    # Apps installed by hand (Discover / `flatpak install`) are left alone
    uninstallUnmanaged = false;

    # Update in the background weekly instead of during every rebuild
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
