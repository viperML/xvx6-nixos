{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "apple-garamond";
  version = "unstable-2022-05-25";

  src = fetchFromGitHub {
    owner = "xvx6";
    repo = "apple-garamond";
    rev = "05a9d4e0984ec05a2f3198292d7dc804c1f8d293";
    sha256 = "070aqxyh50mjsp21p0idhn45l5aylkqp2mba35x4cpi6yil3r848";
  };

  installPhase = ''
    find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/opentype {} \;
  '';
}
