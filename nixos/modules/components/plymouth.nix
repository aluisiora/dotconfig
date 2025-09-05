{
  config,
  lib,
  pkgs,
  ...
}:
let
  theme = "hexagon_dots";
in
{
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
  ];
  boot.plymouth = {
    inherit theme;
    enable = true;
    themePackages = with pkgs; [
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "${theme}" ];
      })
    ];
  };
}
