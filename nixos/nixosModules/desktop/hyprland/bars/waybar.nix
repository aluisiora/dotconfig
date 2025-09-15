{ inputs, pkgs, ... }:
let
  waybar = inputs.waybar.${pkgs.system}.default;
in {
  environment.systemPackages = with pkgs; [
    waybar
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
}
