pkgs: {
  enableSyntaxHighlighting = true;
  enableAutosuggestions = true;
  enableCompletion = true;
  dotDir = ".config/zsh";
  enable = true;

  initExtra = ''
    PROMPT="%F{blue}%m %~%b "$'\n'"%(?.%F{green}%Bλ%b.%F{red}?) %f"
    export EDITOR="emacs";
  '';

  shellAliases = {
    switch = "doas nixos-rebuild switch --flake $HOME/.config/nixos";
    ls = "ls -laugh --color=auto";
    mkdir = "mkdir -vp";
    rm = "rm -rifv";
    cp = "cp -riv";
    mv = "mv -iv";
  };
}
