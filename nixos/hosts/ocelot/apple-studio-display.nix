{
  config,
  lib,
  ...
}:
{
  environment.variables = {
    GDK_SCALE = 1;
    GDK_DPI_SCALE = 2;
    QT_SCALE_FACTOR = 1;
    QT_SCREEN_SCALE_FACTORS=1;
    XCURSOR_SIZE = 24;
  };

  services.xserver.dpi = 218;
  services.displayManager.sddm.enableHidpi = true;

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
