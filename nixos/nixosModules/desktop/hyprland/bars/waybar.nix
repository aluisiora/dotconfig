{
  lib,
  pkgs,
  config,
  ...
}:
{
  config = lib.mkIf (config.desktop.hyprland.bar == "waybar") {
    services.upower.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.geoclue2.enable = true;

    programs.waybar.enable = true;
    environment.systemPackages = with pkgs; [
      swaynotificationcenter
      fuzzel
      cliphist
      wl-clipboard
      hyprpaper
      hypridle
      hyprlock
      hyprpicker
      hyprshot
      hyprsunset
      hyprcursor
    ];
  };
}
