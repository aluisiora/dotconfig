{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  waybar-git = inputs.waybar.${pkgs.system}.waybar;
in
{
  config = lib.mkIf (config.desktop.hyprland.bar == "waybar") {
    services.upower.enable = true;
    services.gnome.gnome-keyring.enable = true;
    services.geoclue2.enable = true;

    environment.systemPackages = with pkgs; [
      waybar-git
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
