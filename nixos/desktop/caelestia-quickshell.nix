{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    quickshell
    ddcutil
    brightnessctl
    app2unit
    cava
    lm_sensors
    aubio
    gcc
    grim
    bluez
    file
    swappy
    wl-clipboard
    libqalculate
    inotify-tools
    coreutils
    findutils
  ];

  fonts.packages = with pkgs; [
    rubik
    material-symbols
    nerd-fonts.caskaydia-cove
  ];
}
