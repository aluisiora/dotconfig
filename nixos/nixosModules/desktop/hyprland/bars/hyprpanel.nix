{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.desktop.hyprland.bar == "hyprpanel") {
    environment.systemPackages = with pkgs; [
      hyprpanel
      hyprshot
      hyprlock
    ];
  };
}
