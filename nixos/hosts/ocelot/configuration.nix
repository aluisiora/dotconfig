{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./apple-studio-display.nix
    ../../nixosModules
  ];

  # Custom modules
  plymouth.enable = true;
  desktop.shell = "hyprland";

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
    vim
    neovim
    yazi
    lazygit
    lazydocker
    bluetui
    duf
    # CLI apps
    coreutils
    findutils
    distrobox
    git
    wget
    curl
    fastfetch
    playerctl
    unzip
    zip
    rar
    psmisc
    btop
    jq
    fzf
    fd
    ripgrep
    rsync
    file
    diff-so-fancy
    tldr
    # Dev
    gnumake
    gcc
    cargo
    nixd
    nixfmt-rfc-style
    lua51Packages.luarocks
    nodejs_24
  ];
  programs.zsh.enable = true;
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
