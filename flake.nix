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
    hyprland = {
      url = "github:hyprwm/hyprland";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ghostty,
      quickshell,
      hyprland,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "X86_64-linux";
          modules = [
            ./configuration.nix
            (import ./hyprland.nix {
              hyprland = hyprland;
              pkgs = nixpkgs.legacyPackages.x86_64-linux;
            })
            #./i3.nix
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
                quickshell.packages.x86_64-linux.default
              ];
            }
            {

            }
          ];
        };
      };
    };
}
