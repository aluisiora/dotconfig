{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default.override {
    withX11 = false;
    withI3 = false;
  };
in
{
  config = lib.mkIf (config.desktop.hyprland.bar == "ii") {
    i18n.inputMethod.type = "fcitx5";
    i18n.inputMethod.fcitx5.waylandFrontend = true;

    services.geoclue2.enable = true;
    services.gnome.gnome-keyring.enable = true;

    qt.enable = lib.mkForce true;
    qt.platformTheme = lib.mkForce "qt5ct";
    qt.style = lib.mkForce "kvantum";

    fonts.packages = with pkgs; [
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      nerd-fonts.caskaydia-cove
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.space-mono
      rubik
      material-symbols

      (callPackage ./pkgs/gabarito-font.nix { })
    ];
    environment.systemPackages = with pkgs; [
      quickshell
      (callPackage ./pkgs/end4-shell.nix { quickshell = quickshell; })
      (callPackage ./pkgs/oneui4-icons.nix { })
      kdePackages.kdialog
      kdePackages.kcmutils
      kdePackages.qt5compat
      kdePackages.qtbase
      kdePackages.qtdeclarative
      kdePackages.qtimageformats
      kdePackages.qtmultimedia
      kdePackages.qtpositioning
      kdePackages.qtquicktimeline
      kdePackages.qtsensors
      kdePackages.qtsvg
      kdePackages.qttools
      kdePackages.qttranslations
      kdePackages.qtvirtualkeyboard
      kdePackages.qtwayland
      kdePackages.syntax-highlighting
      kdePackages.plasma-workspace
      kdePackages.plasma-systemmonitor
      kdePackages.bluedevil
      kdePackages.bluez-qt
      kdePackages.plasma-nm
      kdePackages.kwallet
      kdePackages.polkit-kde-agent-1

      # Audio
      cava
      lxqt.pavucontrol-qt
      wireplumber
      libdbusmenu-gtk3
      playerctl
      easyeffects

      # Bluetooth
      bluetui

      # Backlight
      brightnessctl
      ddcutil

      # Screenshot
      hyprshot
      slurp
      swappy
      tesseract
      wf-recorder

      # Toolkit
      # wtype
      # ydotool
      hyprpicker

      # Widgets
      # glib
      # swww
      translate-shell
      wlogout

      # Misc
      bc
      cliphist
      curl
      libqalculate
      jq
      fuzzel
      matugen
      wl-clipboard
      imagemagick
      # libsoup_3
      # libportal-gtk4
      # gobject-introspection
      # sassc
      # opencv
      python313Packages.kde-material-you-colors
      (python3.withPackages (
        python-pkgs: with python-pkgs; [
          build
          pillow
          setuptools-scm
          wheel
          pywayland
          psutil
          materialyoucolor
          libsass
          material-color-utilities
          setproctitle
        ]
      ))
    ];
  };
}
