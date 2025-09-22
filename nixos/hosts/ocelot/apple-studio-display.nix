{
  config,
  lib,
  ...
}:
{
  services.xserver.dpi = 218;
  services.displayManager.sddm.enableHidpi = true;
  services.displayManager.sddm.settings = {
    General = {
      GreeterEnvironment = "QT_SCREEN_SCALE_FACTORS=2,XCURSOR_SIZE=48";
    };
  };

  fonts.fontconfig = {
    enable = true;
    hinting.enable = false;
    subpixel.lcdfilter = "none";
    subpixel.rgba = "none";
  };

  hardware.i2c.enable = true;

  systemd.tmpfiles.rules = lib.mkIf config.services.displayManager.gdm.enable [
    "L+ /run/gdm/.config/monitors.xml - - - - ${./monitors.xml}"
  ];
}
