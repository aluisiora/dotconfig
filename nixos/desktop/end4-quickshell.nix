{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  i18n.inputMethod.type = "fcitx5";
  i18n.inputMethod.fcitx5.waylandFrontend = true;

  services.upower.enable = true;
  services.geoclue2.enable = true;
  services.gnome.gnome-keyring.enable = true;

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
    kdePackages.bluedevil
    kdePackages.bluez-qt
    kdePackages.plasma-nm
    kdePackages.kwallet
    kdePackages.polkit-kde-agent-1

    (callPackage ./oneui4-icons.nix { })

    # Audio
    cava
    lxqt.pavucontrol-qt
    wireplumber
    libdbusmenu-gtk3
    playerctl
    easyeffects

    # Backlight
    brightnessctl
    ddcutil

    # Toolkit
    # wtype
    # ydotool
    hyprpicker
    hyprshot

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
}
