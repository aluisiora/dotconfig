{ config, lib, pkgs, ... }:
{
  environment.variables = {
    GDK_SCALE = "2";
    QT_SCALE_FACTOR = "2";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  services.xserver.dpi = 218;
  services.displayManager.sddm.enableHidpi = true;

  fonts.fontconfig = {
    enable = true;
    hinting.enable = false;
    subpixel.lcdfilter = "none";
    subpixel.rgba = "none";
  };

  environment.systemPackages = with pkgs; [
    ddcutil
  ];

  hardware.i2c.enable = true;
}
