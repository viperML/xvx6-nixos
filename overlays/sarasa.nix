self: super: rec {
  sourceRoot = "./";
  installPhase = ''
    find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/opentype {} \;
  '';

  sarasa =
    super.stdenv.mkDerivation
    {
      pname = "sarasa";
      version = "1.0";

      src = super.pkgs.fetchFromGitHub {
        url = "https://github.com/xvx6/sarasa.git";
      };

      inherit sourceRoot installPhase;
    };
}
