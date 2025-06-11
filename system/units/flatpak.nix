{...}: {
  services.flatpak = {
    enable = true;
    uninstallUnmanaged = true;
    update.auto = {
      enable = true;
      onCalendar = "daily";
    };
    packages = [
      "com.microsoft.Edge"
    ];
  };
}
