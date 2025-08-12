{ config, lib, pkgs, ... }:
{
  imports = [ ./caelestia-quickshell.nix ];

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
    style = "adwaita-dark";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];
  };

  services.xserver.enable = true;
  services.hypridle.enable = true;
  services.gvfs.enable = true;

  # services.displayManager.sddm =
  #   { enable = true;
  #     # wayland.enable = true;
  #     theme = "catppuccin-mocha";
  #     package = pkgs.kdePackages.sddm;
  #   };
  services.displayManager.ly.enable = true;

  environment.systemPackages = with pkgs; [
    hyprpaper
    hyprpicker
    hyprshot
    tesseract
    gnome-themes-extra
    gnome-keyring
    libsForQt5.qt5ct
    adwaita-qt
    hicolor-icon-theme
    wlogout
    wl-clipboard
    wf-recorder

    # Apps
    ghostty
    nautilus
    flameshot
    keepassxc
    file-roller
  ];

  fonts.enableDefaultPackages = true;
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
}
