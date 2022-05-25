{
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "sarasa";
  version = "unstable-2022-05-25";

  src = fetchFromGitHub {
    url = "https://github.com/xvx6/sarasa.git";
    owner = "xvx6";
    repo = "sarasa";
    rev = "cc4f6e4a5e4b254251ebec14f965b6633f6db364";
    sha256 = "1q1aj428a2s2gjqapn6whjcs84wqi8lv2q1irlk2l637nmcblhdd";
  };

  installPhase = ''
    find . -name '*.ttf' -exec install -m444 -Dt $out/share/fonts/opentype {} \;
  '';
}
