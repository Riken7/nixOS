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
    nix-flatpak = {
      url = "github:gmodena/nix-flatpak/?ref=latest";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #zen-browser = {
    #  url = "github:0xc000022070/zen-browser-flake";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #zen-nebula.url = "github:JustAdumbPrsn/Nebula-A-Minimal-Theme-for-Zen-Browser";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ghostty,
      nix-flatpak,
      quickshell,
      sops-nix,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib;
      system =  "x86_64-linux";
    in
    {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { inherit inputs; };
          system = "x86_64-linux";
          modules = [
          sops-nix.nixosModules.sops
            ./configuration.nix
            ./hyprland.nix
            nix-flatpak.nixosModules.nix-flatpak
            #./i3.nix
            #home-manager setup ==>
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };

              home-manager.users.rik = import ./home.nix;
            }
            {
              environment.systemPackages = [
                ghostty.packages.${system}.default
                quickshell.packages.${system}.default
              ];
            }
            {

            }
          ];
        };
      };
    };
}
