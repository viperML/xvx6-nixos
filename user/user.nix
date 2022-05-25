{
  config,
  pkgs,
  ...
}: let
  conf-dir = "${config.home.homeDirectory}/.config/nixos";
  kitty = import ./apps/kitty.nix;
  git = import ./apps/git.nix;
  zsh = import ./apps/zsh.nix;
  gh = import ./apps/gh.nix;
  ff = import ./apps/ff.nix;
in {
  systemd.user.sessionVariables = {DISPLAY = ":0";}; # because of picom service
  programs = {
    home-manager.enable = true;
    kitty = kitty pkgs;
    firefox = ff pkgs;
    git = git pkgs;
    zsh = zsh pkgs;
    gh = gh pkgs;
  };

  home.file = {
    ".config/berry/autostart" = {
      text = ''
        #!/bin/sh

        berryc border_width       0
        berryc inner_border_width 0
        berryc title_height       35
        berryc edge_gap           30 30 30 30

        berryc inner_focus_color   c9c1bd
        berryc inner_unfocus_color 2c363c

        berryc draw_text "false"
        berryc smart_place "true"
        berryc edge_lock   "true"

        pgrep sxhkd || sxhkd -c "$HOME/.config/berry/sxhkdrc" &
        picom &
      '';

      executable = true;
    };

    ".config/berry/sxhkdrc".source = config.lib.file.mkOutOfStoreSymlink "${conf-dir}/config/berry/sxhkdrc";
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
