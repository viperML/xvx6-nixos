{
  config,
  pkgs,
  ...
}: {
  imports = [./configuration.nix ./hardware-configuration.nix];
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = ["sarasa"];
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
    };

    extraOptions = "experimental-features = nix-command flakes";
    package = pkgs.nixUnstable;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = true;
  };
}
