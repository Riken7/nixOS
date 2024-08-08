{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, here using the nixos-23.11 branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:  
   let  
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
   in
    {
    # The host with the hostname `my-nixos` will use this configuration
	specialArgs = {inherit inputs;};
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
      ];
    };
  };
}
