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

    emacs.url = "github:nix-community/emacs-overlay";
    nix.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    emacs,
    self,
    nix,
    nur,
    hm,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    hostname = "ephemeral";
    user = "agir";
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
          nixpkgs.overlays = [emacs.overlay nur.overlay];
        }

        ./system
      ];

      specialArgs = inputs;
      inherit system;
    };
  };
}
