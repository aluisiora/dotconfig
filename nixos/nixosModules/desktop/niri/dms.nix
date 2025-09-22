{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
  dgop = inputs.dgop.packages.${pkgs.system}.default;
  dms = pkgs.callPackage ./pkgs/dank-material-shell.nix { quickshell = quickshell; };
  dms-cli = inputs.dms-cli.packages.${pkgs.system}.default;
in
{
  options = {
    desktop.niri.dms.enable = lib.mkEnableOption "Dank Material quickshell configuration";
  };

  config = lib.mkIf config.desktop.niri.dms.enable {
    fonts.packages = with pkgs; [
      fira-code
      inter
      material-symbols
    ];

    services.upower.enable = true;
    services.geoclue2.enable = true;

    environment.systemPackages = with pkgs; [
      # Shell
      quickshell
      dms
      dms-cli
      libsForQt5.qt5ct
      kdePackages.qt6ct
      ddcutil
      glib
      # System monitor
      dgop
      # Networking and VPN
      networkmanager
      networkmanager-l2tp
      networkmanager-openvpn
      # Brightness control
      brightnessctl
      # Dynamic theming
      matugen
      # Clipboard
      wl-clipboard
      cliphist
      # Nightmode
      gammastep
      # Calendar events
      khal
      # Audio waves
      cava
    ];
  };
}
