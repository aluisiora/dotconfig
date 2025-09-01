{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  environment.variables = {
    PRECONFIGURED_SHELL = "caelestia";
  };

  environment.systemPackages = with inputs; [
    caelestia.packages.${pkgs.system}.with-cli
  ];
}
