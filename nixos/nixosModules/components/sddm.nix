{
  pkgs,
  lib,
  config,
  ...
}:
let

  sddm-theme =
    if config.desktop.sddm.theme == "rose-pine" then
      pkgs.callPackage ./pkgs/sddm-rose-pine.nix { }
    else
      pkgs.sddm-astronaut.override { embeddedTheme = config.desktop.sddm.theme; };
in
{
  imports = [
    ./pkgs/sddm-rose-pine.nix
  ];

  options = {
    desktop.sddm = {
      enable = lib.mkEnableOption "themed sddm";
      theme = lib.mkOption {
        type = lib.types.anything;
        # Themes: https://github.com/Keyitdev/sddm-astronaut-theme/tree/master/Themes
        default = "astronaut";
        description = "SDDM Theme";
      };
    };
  };

  config = lib.mkIf config.desktop.sddm.enable {
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
      theme = if config.desktop.sddm.theme == "rose-pine" then "rose-pine" else "sddm-astronaut-theme";
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
      sddm-theme
    ];
  };
}
