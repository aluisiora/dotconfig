{
  pkgs,
  inputs,
  ...
}:
{
  imports = [ ./desktop ./components ];

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
    EDITOR = "nvim";
  };

  environment.systemPackages = with pkgs; [
    vim
    # CLI apps
    coreutils
    findutils
    git
    wget
    curl
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
    # Misc
    xdg-user-dirs
  ];

  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.optimise.automatic = true;
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 10d";
}
