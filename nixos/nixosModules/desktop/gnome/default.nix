{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    desktop = {
      gnome = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable GNOME Desktop Environment";
        };
      };
    };
  };

  config = lib.mkIf config.desktop.gnome.enable {
    environment.systemPackages = with pkgs; [
      xdg-user-dirs-gtk
    ];
  };
}
