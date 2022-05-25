self: super: rec {
  sourceRoot = "./";
  installPhase = ''
    find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/opentype {} \;
  '';

  apple-garamond =
    super.stdenv.mkDerivation
    {
      pname = "apple-garamond";
      version = "1.0";

      src = super.pkgs.fetchFromGitHub {
        url = "https://github.com/xvx6/apple-garamond.git";
      };

      inherit sourceRoot installPhase;
    };
}
