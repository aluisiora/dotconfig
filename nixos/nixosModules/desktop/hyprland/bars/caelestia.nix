{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  config = lib.mkIf (config.desktop.hyprland.bar == "caelestia") {
    services.upower.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.geoclue2.enable = true;

    environment.systemPackages = with inputs; [
      caelestia.packages.${pkgs.system}.with-cli
    ];
  };
}
