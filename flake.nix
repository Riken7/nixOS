{
  description = "system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ghostty,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          system = "X86_64-linux";
          modules = [
            ./configuration.nix
            #./hyprland.nix
            ./i3.nix
            #home-manager setup ==>
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.rik = import ./home.nix;
            }
            {
              environment.systemPackages = [
                ghostty.packages.x86_64-linux.default
              ];
            }
          ];
        };
      };
    };
}
