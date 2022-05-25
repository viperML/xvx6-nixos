pkgs: {
  extensions = with pkgs.vscode-extensions; [
    material-icon-theme
    jnoortheen.nix-ide
  ];

  userSettings = {
    "workbench.iconTheme" = "material-icon-theme";
    "nix.enableLanguageServer" = true;
    "git.confirmSync" = false;
    "git.autofetch" = true;
  };
}
