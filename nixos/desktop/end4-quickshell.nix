{ config, lib, pkgs, ... }:
{
  # fonts.packages = with pkgs; [
    # ubuntu
    # ubuntu-mono
    # jetbrains-mono
    # caskaydia-cove
    # fantasque-sans-mono
    # monoki
    # space-mono
    # rubik
  # ];
  environment.systemPackages = with pkgs; [
    quickshell
    # Audio
    # cava
    # lxqt.pavucontrol-qt
    # wireplumber
    # libdbusmenu-gtk3
    # playerctl
    
    # Backlight
    # brightnessctl
    # ddcutil

    # Toolkit
    # upower
    # wtype
    # ydotool

    # Widgets
    # glib
    # swww
    # translate-shell
    # wlogout

    # Misc
    # axel
    # bc
    # cliphist
    # curl
    # rsync
    # wget
    # libqalculate
    # ripgrep
    # jq
    # fuzzel
    # matugen
    # libsoup_3
    # libportal-gtk4
    # gobject-introspection
    # sassc
    # opencv
    # material-symbols
    # kdePackages.bluedevil
    # kdePackages.plasma-nm
    # kdePackages.polkit-kde-agent-1
    kdePackages.qtsvg
    kdePackages.qtimageformats
    kdePackages.qtmultimedia
    kdePackages.qt5compat
    # (python3.withPackages (python-pkgs: with python-pkgs; [
    #   build
    #   pillow
    #   setuptools-scm
    #   wheel
    #   pywayland
    #   psutil
    #   materialyoucolor
    #   libsass
    #   material-color-utilities
    #   setproctitle
    # ]))
  ];

  programs.nm-applet.enable = true;
  services.geoclue2.enable = true;
}
