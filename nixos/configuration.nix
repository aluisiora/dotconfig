{ config, lib, pkgs, ... }:
{
  imports = [ ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "mio";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Sao_Paulo";
  i18n.defaultLocale = "en_US.UTF-8";
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
  };
  security.rtkit.enable = true;
  services.libinput.enable = true;

  users.defaultUserShell = pkgs.zsh;
  users.users.aluisio = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "docker" ];
  };

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    EDITOR = "nvim";
  };
  environment.systemPackages = with pkgs; [
    # TUI apps
    tmux
    vim
    neovim
    yazi
    lazygit

    # CLI apps
    distrobox
    git
    wget
    curl
    fastfetch
    playerctl
    unzip
    zip
    psmisc
    btop
    fzf
    fd
    ripgrep

    # Dev
    gnumake
    gcc
    cargo
    nil
    lua51Packages.luarocks
  ];

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;

  services.openssh.enable = true;

  system.stateVersion = "25.05"; 
}
