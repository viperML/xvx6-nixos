{
  inputs = {
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nix.follows = "nixpkgs";
    };

    emacs.url = "github:nix-community/emacs-overlay";
    nix.url = "nixpkgs/nixos-unstable";
  };

  outputs = {
    emacs,
    self,
    nix,
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
          nixpkgs.overlays = [emacs.overlay];
        }

        ./system
      ];

      specialArgs = inputs;
      inherit system;
    };
  };
}
