{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "end-4-dots-hyprland";
  version = "unstable-2025-09-09";

  src = fetchFromGitHub {
    owner = "end-4";
    repo = "dots-hyprland";
    rev = "f648137a8e338223170c1cfd7deb159a74b7da7e";
    sha256 = "sha256-VWgITEJQFbPqIbiGDfDeD0R74y9tCKEfjO/M/tcO94M=";
  };

  installPhase = ''
    runHook preInstall

    cp -R .config/quickshell/ii $out/share/illogical-impulse
    echo -e "#!/usr/bin/env sh\n\nqs --path $out/share/illogical-impulse" > $out/bin/illogical-impulse
    chmod +x $out/bin/illogical-impulse

    runHook postInstall
  '';

  meta = {
    description = "Rice built for usability";
    homepage = "https://end-4.github.io/dots-hyprland-wiki/en/";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
