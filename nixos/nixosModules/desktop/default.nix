{ config, lib, ... }:
{
  import = [
    ./gnome
    ./hyprland
  ];

  options = {
    desktop = {
      shell = lib.mkOption {
        type = lib.types.enum [
          "gnome"
          "hyprland"
          "none"
        ];
        default = "hyprland";
        description = "Choose the desktop shell to use.";
      };
    };
  };

  desktop.hyprland.enable = lib.mkif (config.desktop.shell == "hyprland") true;
  desktop.gnome.enable = lib.mkif (config.desktop.shell == "gnome") true;
}
