{
  quickshell,
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation {
  pname = "dank-material-shell";
  version = "6e6412";

  src = fetchFromGitHub {
    owner = "AvengeMedia";
    repo = "DankMaterialShell";
    rev = "6e6412fffc67f1fd047ca6e636ee1fe8a51ee5d8";
    sha256 = "sha256-udD0jHffaajWIgbXx5nAiCDhZ3P8YXVrMI6m1dTXXDs=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/dank-material

    cp -r $src $out/share/dank-material/shell
    cat > $out/bin/dank-material-shell << EOF
    #!/usr/bin/env sh
    ${quickshell}/bin/quickshell --path $out/share/dank-material/shell
    EOF
    chmod +x $out/bin/dank-material-shell

    patchShebangs $out/bin/dank-material-shell

    runHook postInstall
  '';

  meta = {
    description = "Quickshell optimized for niri & hyprland.";
    homepage = "https://github.com/AvengeMedia/DankMaterialShell";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
