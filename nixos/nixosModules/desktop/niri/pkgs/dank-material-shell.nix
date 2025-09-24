{
  quickshell,
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "dank-material-shell";
  version = "7516d44de9998ee00620a2f6f7c15354c1256633";

  src = fetchFromGitHub {
    owner = "AvengeMedia";
    repo = "DankMaterialShell";
    rev = "${version}";
    sha256 = "sha256-1d0nMd5DdYs5zeJlPInILHMhIaz1PnSieOhdwF63tg0=";
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
