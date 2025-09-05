{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./apple-studio-display.nix
    ../../modules/components/plymouth.nix
    ../../modules
  ];

  networking.hostName = "ocelot";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
}
