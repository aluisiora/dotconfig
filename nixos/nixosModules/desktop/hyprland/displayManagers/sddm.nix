{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    desktop.hyprland.sddm = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Use SDDM as display manager";
      };
      theme = lib.mkOption {
        type = lib.types.anything;
        default = "japanese_aesthetic";
        description = "SDDM Theme";
      };
    };
  };

  config = lib.mkIf config.desktop.hyprland.sddm.enable {
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

    environment.systemPackages = with pkgs; [
      rose-pine-cursor
      xorg.xrdb
      (sddm-astronaut.override { embeddedTheme = config.desktop.hyprland.sddm.theme; })
    ];
  };
}
