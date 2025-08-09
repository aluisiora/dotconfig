{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.variables = {
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
    tofi
    wofi
    waybar
    hyprpaper
    hyprshot
    hyprpicker
    swaynotificationcenter
    pavucontrol
    gnome-themes-extra
    libsForQt5.qt5ct
    adwaita-qt
    catppuccin-sddm
    hicolor-icon-theme
    grim
    wlogout

    # Apps
    ghostty
    nautilus
    flameshot
    keepassxc
    nwg-look
  ];

  fonts.enableDefaultPackages = true;
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Liberation Serif 8pt" ];
      sansSerif = [ "Lato Sans 8pt" ];
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
    font-awesome
    pango
    nerd-fonts.fantasque-sans-mono

    # Windows fonts
    corefonts
    vista-fonts
  ];
}
