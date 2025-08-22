{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  services.upower.enable = true;
  services.geoclue2.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.space-mono
    rubik
    material-symbols

    (callPackage ./gabarito-font.nix { })
  ];
  environment.systemPackages = with pkgs; [
    # Dependencies
    inputs.quickshell.packages.${pkgs.system}.default
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

    (callPackage ./oneui4-icons.nix { })

    # Audio
    cava
    lxqt.pavucontrol-qt
    wireplumber
    libdbusmenu-gtk3
    playerctl

    # Backlight
    brightnessctl
    ddcutil

    # Toolkit
    # wtype
    # ydotool

    # Widgets
    # glib
    swww
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
    # libsoup_3
    # libportal-gtk4
    # gobject-introspection
    # sassc
    # opencv
    # kdePackages.bluedevil
    # kdePackages.plasma-nm
    # kdePackages.polkit-kde-agent-1
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
}
