{ lib, stdenv, fetchurl
}:

stdenv.mkDerivation rec {
  pname = "million-random-digits";
  version = "1.0";
  src = fetchurl {
    url = https://oeis.org/A002205/b002205.txt;
    sha256 = "0q6zhp5zb8rrmwi8k1b00p2p0fsp621l6yhd2p39jgfrccsvbs13";
  };
  template = ./template.md;
  unpackPhase = "true";
  buildPhase = ''
    cat $src | awk 'begin {x=""} {x=x$2; if (length(x) >= 2) { if (x+0 >= 1 && x+0 <= 20) {printf "%d ", x;} x=""; }}' > numbers
  '';
  installPhase = ''
    cat $template > $out
    cat numbers >> $out
  '';
}
