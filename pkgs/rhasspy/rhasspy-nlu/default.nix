{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, num2words
, networkx
, numpy
, grapheme
}:

buildPythonPackage rec {
  pname = "rhasspy-nlu";
  version = "0.4.0";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-DnW4G9w3MDHoSEgm3E+ZZDroMvofBcWJ91fUk4lrSMI=";
  };

  postPatch = ''
    substituteInPlace requirements.txt \
      --replace "networkx==2.4" "networkx~=2.4"
  '';

  propagatedBuildInputs = [
    num2words
    networkx
    numpy
    grapheme
  ];

  # misses files from the repo
  doCheck = false;

  meta = with lib; {
    description = "Natural language understanding library for Rhasspy";
    homepage = "https://github.com/rhasspy/rhasspy-nlu";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
