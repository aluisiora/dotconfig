{
  quickshell,
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "dank-material-shell";
  version = "92bb5b90aab82ee0af96ac21832f7fb8f223f09d";

  src = fetchFromGitHub {
    owner = "AvengeMedia";
    repo = "DankMaterialShell";
    rev = "${version}";
    sha256 = "sha256-FY4nQwEPl/7mwSd4tturVNU+kHQ5oJyGjnljlFiI1RY=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/dank-material

    cp -r $src $out/share/dank-material/shell
    cat > $out/bin/dms-shell << EOF
    #!/usr/bin/env sh
    ${quickshell}/bin/quickshell --path $out/share/dank-material/shell \$@
    EOF
    chmod +x $out/bin/dms-shell

    patchShebangs $out/bin/dms-shell

    runHook postInstall
  '';

  meta = {
    description = "Quickshell optimized for niri & hyprland.";
    homepage = "https://github.com/AvengeMedia/DankMaterialShell";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
