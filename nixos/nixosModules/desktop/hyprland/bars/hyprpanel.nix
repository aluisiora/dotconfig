{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    desktop.hyprland.hyprpanel.enable = lib.mkEnableOption "hyprpanel configuration";
  };

  config = lib.mkIf config.desktop.hyprland.hyprpanel.enable {
    environment.systemPackages = with pkgs; [
      hyprpanel
      hyprshot
      hyprlock
    ];
  };
}
