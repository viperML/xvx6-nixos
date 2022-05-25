## Building


```console
nix-build -E "with import <nixpkgs> {}; callPackage ./PACKAGE.nix {}"
```

## Updating


```console
nix-shell -p update-nix-fetchgit --command "update-nix-fetchgit ./PACKAGE.nix"
```
