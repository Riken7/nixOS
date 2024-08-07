{
  description = "system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {self , nixpkgs , ...}@inputs:
	let 
	  lib = nixpkgs.lib;
	in {
	nixosConfigurations = {
		nixos = lib.nixosSystem{
			system = "X86_64-linux";
			modules = [./configuration.nix];
			};
		};
	};
	
}
