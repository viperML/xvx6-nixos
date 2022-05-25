{
  inputs = {
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nix.follows = "nixpkgs";
    };

    nur = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/NUR";
    };

    nix.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nix,
    nur,
    hm,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    hostname = "ephemeral";
    user = "sarasa";
  in {
    nixosConfigurations.${hostname} = nix.lib.nixosSystem {
      modules = [
        hm.nixosModules.home-manager
        {
          home-manager = {
            users.${user} = import ./user;
            useUserPackages = true;
            useGlobalPkgs = true;
          };
        }

        {
          nixpkgs.overlays = [
            nur.overlay
            (import ./overlays)
          ];
        }

        ./system
      ];

      specialArgs = inputs;
      inherit system;
    };
  };
}
