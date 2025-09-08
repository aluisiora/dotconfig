{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  environment.variables = {
    WAYLAND_BAR = "caelestia";
  };

  environment.systemPackages = with inputs; [
    caelestia.packages.${pkgs.system}.with-cli
  ];
}
