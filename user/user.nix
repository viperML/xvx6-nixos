{
  config,
  pkgs,
  ...
}: let
  conf-dir = "${config.home.homeDirectory}/.config/nixos";
in {
  systemd.user.sessionVariables = {DISPLAY = ":0";}; # because of picom service
  programs = {
    home-manager.enable = true;
  };

  home.file = {
    ".config/berry".source =
      config.lib.file.mkOutOfStoreSymlink "${conf-dir}/config/berry";

    ".emacs.d".source =
      config.lib.file.mkOutOfStoreSymlink "${conf-dir}/config/emacs";
  };

  services = {
    picom = {
      extraOptions = ''
        corner-radius = 5;
        dbe = true;
      '';

      experimentalBackends = true;
      package = pkgs.picom-next;
      backend = "glx";
      enable = true;
      vSync = true;
    };
  };
}
