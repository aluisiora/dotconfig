{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./plymouth.nix
    ./end4-quickshell.nix
  ];

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    USE_WAYLAND_GRIM = "1";
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.firefox.enable = true;
  programs.hyprlock.enable = true;
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            gtk-theme = "Adwaita";
            icon-theme = "Adwaita";
            font-name = "Lato Regular 11";
            document-font-name = "Lato Regular 11";
            monospace-font-name = "Fira Mono Medium 13";
          };
        };
      }
    ];
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };
  xdg.mime = {
    enable = true;
    defaultApplications = {
      "default-web-browser" = [ "google-chrome.desktop" ];
      "text/html" = [ "google-chrome.desktop" ];
      "text/xml" = [ "google-chrome.desktop" ];
      "application/pdf" = [ "google-chrome.desktop" ];
      "x-scheme-handler/http" = [ "google-chrome.desktop" ];
      "x-scheme-handler/https" = [ "google-chrome.desktop" ];
      "x-scheme-handler/xhtml+xml" = [ "google-chrome.desktop" ];
      "x-scheme-handler/about" = [ "google-chrome.desktop" ];
      "x-scheme-handler/unknown" = [ "google-chrome.desktop" ];
    };
  };

  services.xserver.enable = true;
  services.hypridle.enable = true;
  services.gvfs.enable = true;
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "intl";
      options = "";
    };
  };

  # Set cursor and turn display off
  services.xserver.displayManager.setupCommands = ''
    # Load cursor settings into the X server's resource database
    ${pkgs.xorg.xrdb}/bin/xrdb -merge - <<EOF
    Xcursor.theme: BreezeX-RosePine-Linux
    Xcursor.size: 48
    EOF

    ${pkgs.xorg.xset}/bin/xset s 30 30
    ${pkgs.xorg.xset}/bin/xset dpms 30 30 30
  '';
  services.displayManager.sddm = {
    enable = true;
    theme = "sddm-astronaut-theme";
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtsvg
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
  };

  fonts.enableDefaultPackages = true;
  fonts.fontDir.enable = true;
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Liberation Serif" ];
      sansSerif = [ "Lato Regular" ];
      monospace = [ "Fira Code Mono" ];
    };
  };
  fonts.packages = with pkgs; [
    lato
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    dejavu_fonts
    fira-code
    fira-code-symbols
    jetbrains-mono
    open-sans
    liberation_ttf

    # Windows fonts
    corefonts
    vista-fonts
  ];

  environment.systemPackages = with pkgs; [
    rose-pine-cursor
    gnome-themes-extra
    libsForQt5.qt5ct
    kdePackages.qt6ct
    kdePackages.breeze
    kdePackages.breeze-icons
    adwaita-qt
    hicolor-icon-theme
    xdg-user-dirs
    xdg-user-dirs-gtk
    xsettingsd
    xorg.xrdb

    # SDDM
    (sddm-astronaut.override { embeddedTheme = "japanese_aesthetic"; })

    # Apps
    google-chrome
    ytmdesktop
    ghostty
    wezterm
    nautilus
    flameshot
    keepassxc
    file-roller
    gnome-font-viewer
    slack

    # Panel
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtsvg
    kdePackages.qtwayland
    (inputs.quickshell.packages.${pkgs.system}.default.override {
      withX11 = false;
      withI3 = false;
    })
  ];
}
