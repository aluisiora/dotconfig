{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./gnome
    ./hyprland
  ];

  options = {
    desktop = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable desktop base configuration";
      };
    };
  };

  config = lib.mkIf config.desktop.enable {
    desktop.hyprland.enable = lib.mkDefault true;
    programs.firefox.enable = true;
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
    services.xserver.enable = true;
    services.xserver = {
      xkb = {
        layout = "us,us";
        variant = "altgr-intl,";
        options = "grp:alt_space_toggle";
      };
    };
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      noto-fonts-cjk-sans
      lato
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
      google-chrome
      ytmdesktop
      ghostty
      wezterm
      keepassxc
      slack
    ];
  };
}
