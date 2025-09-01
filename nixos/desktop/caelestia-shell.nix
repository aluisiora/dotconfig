{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with inputs; [
    caelestia.packages.${pkgs.system}.with-cli
  ];
}
