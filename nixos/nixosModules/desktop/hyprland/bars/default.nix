{ lib, config, ... }:
{
  options = {
    desktop.hyprland.bar = lib.mkOption {
      type = lib.types.enum [
        "illogical-impulse"
        "caelestia"
        "hyprpanel"
      ];
      default = "illogical-impulse";
      description = "Hyprland bar to configure";
    };
  };
}
