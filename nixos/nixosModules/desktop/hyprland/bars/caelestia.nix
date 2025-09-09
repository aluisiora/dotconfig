{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  options = {
    desktop.hyprland.caelestia.enable = lib.mkEnableOption "caelestia shell";
  };

  config = lib.mkIf config.desktop.hyprland.caelestia.enable {
    environment.variables = {
      WAYLAND_BAR = "caelestia";
    };

    environment.systemPackages = with inputs; [
      caelestia.packages.${pkgs.system}.with-cli
    ];
  };
}
