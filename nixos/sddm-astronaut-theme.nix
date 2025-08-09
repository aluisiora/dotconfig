{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "sddm-astronaut-theme";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "Keyitdev";
    repo = "sddm-astronaut-theme";
    rev = "071ad6eb9be8c0f6465cfe23798dc4b99e4e4b49";
    sha256 = "3rvvQTWL5NytpylV7KuSyeHIjg3HDz8Xy4hoHShj0KU=";
  };

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/${pname}
  '';
}
