{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./shells/hyprland
  ];

  nixpkgs.config.allowUnfree = true;

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
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "docker"
    ];
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
    gemini-cli

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

  services.openssh.enable = true;

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";

  system.stateVersion = "25.05";
}
