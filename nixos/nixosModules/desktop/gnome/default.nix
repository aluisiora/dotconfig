{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    desktop.gnome.enable = lib.mkEnableOption "gnome shell";
  };

  config = lib.mkIf config.desktop.gnome.enable {
    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.gnome.games.enable = false;

    environment.variables = {
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      USE_WAYLAND_GRIM = "1";
    };

    environment.systemPackages = with pkgs; [
      gnomeExtensions.appindicator
      xdg-user-dirs
      xdg-user-dirs-gtk
    ];
  };
}
