{
  description = "NixOS system for Mio";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";
  };

  outputs = { self, nixpkgs, lanzaboote, ... }: {
    nixosConfigurations.mio = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./desktop.nix
        ./apple-studio-display.nix
      	./beelink-ser5-configuration.nix
	      lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
