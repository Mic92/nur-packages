{ lib
, buildPythonPackage
, fetchFromGitHub
, swig
, pkgconfig
, ncurses
, openblas
, blas
, lapack
, pyaudio
}:

assert blas.implementation == "openblas" && lapack.implementation == "openblas";

buildPythonPackage rec {
  pname = "snowboy";
  version = "v1.3.0";

  src = fetchFromGitHub {
    owner = "Kitt-AI";
    repo = pname;
    rev = version;
    sha256 = "186r8ihbhw76878244g3m56zwc4wcrdiriamvjp6s1hi6i35364s";
  };

  patches = [
    ./0001-use-openblas-instead-of-atlas.patch
  ];

  nativeBuildInputs = [
    swig
    pkgconfig
  ];

  buildInputs = [
    ncurses
    lapack
    blas
    openblas
  ];

  propagatedBuildInputs = [
    pyaudio
  ];

  meta = with lib; {
    description = "DNN based hotword and wake word detection toolkit";
    homepage = "https://github.com/Kitt-AI/snowboy";
    license = licenses.asl20;
  };
}
