{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./apple-studio-display.nix
    ../../nixosModules
  ];

  # Custom modules
  desktop = {
    enable = true;
    niri.enable = true;
    niri.dms.enable = true;
    extraPackages = with pkgs; [
        google-chrome
        slack
    ];
    sddm = {
      enable = true;
      theme = "purple_leaves";
    };
  };

  environment.variables = {
    EDITOR = "nvim";
    ZDOTDIR = "$HOME/.config/zsh";
  };

  # System config
  nixpkgs.config.allowUnfree = true;
  networking.hostName = "ocelot";
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
  services.openssh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.aluisio = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "docker"
    ];
  };
  environment.systemPackages = with pkgs; [
    # TUI apps
    tmux
    neovim
    yazi
    lazygit
    lazydocker
    duf
    # CLI apps
    distrobox
    fastfetch
    # Dev
    gnumake
    gcc
    cargo
    nixd
    nixfmt-rfc-style
    lua51Packages.luarocks
    nodejs_24
  ];
  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false;
  };
  programs.nix-ld.enable = true;
  programs.direnv.enable = true;
  programs.direnv.silent = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  system.stateVersion = "25.05";
}
