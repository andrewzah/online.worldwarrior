{ stdenv, ... }:
stdenv.mkDerivation {
  pname = "worldwarrior-online-html";
  version = "0.1";

  src = ./src;

  installPhase = ''
    mkdir -p $out/var/www/online.worldwarrior
    mv ./* $out/var/www/online.worldwarrior
  '';
}
