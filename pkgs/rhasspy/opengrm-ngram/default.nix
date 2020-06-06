{ stdenv, autoreconfHook, fetchurl, openfst }:

stdenv.mkDerivation rec {
  pname = "opengrm-ngram";
  version = "1.3.9";

  src = fetchurl {
    url = "http://www.openfst.org/twiki/pub/GRM/NGramDownload/ngram-${version}.tar.gz";
    sha256 = "1rhpqpfppp16r0lgbmcjxwkwz42hzyzh3f6dmc0w2w017bg1s64w";
  };

  enableParallelBuilding = true;

  nativeBuildInputs = [
    autoreconfHook
  ];

  buildInputs = [
    openfst
  ];

  meta = with stdenv.lib; {
    description = "Library to make and modify n-gram language models encoded as weighted finite-state transducers";
    homepage = "http://www.openfst.org/twiki/bin/view/GRM/NGramLibrary";
    license = licenses.mit;
    maintainers = with maintainers; [ mic92 ];
    platforms = platforms.unix;
  };
}
