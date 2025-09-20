{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [
    ./waybar.nix
    ./dms.nix
  ];

  options = {
    desktop.niri = {
      enable = lib.mkEnableOption "niri environment";
    };
  };

  config = lib.mkIf config.desktop.niri.enable {
    environment.variables = {
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      USE_WAYLAND_GRIM = "1";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    programs.niri.enable = true;

    services.gvfs.enable = true;
    services.dbus.enable = true;

    fonts.packages = with pkgs; [
      lato
    ];

    environment.systemPackages = with pkgs; [
      rose-pine-cursor
      nautilus
      file-roller
      gnome-font-viewer
      papers
      xwayland-satellite
    ];
  };
}
