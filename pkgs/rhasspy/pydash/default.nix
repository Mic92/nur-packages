{ lib
, buildPythonPackage
, fetchPypi
, pytest
, mock
}:

buildPythonPackage rec {
  pname = "pydash";
  version = "5.0.2";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-fAL1wnUkq72QdDxLYP2MjI6EbuBDlkJwT3ejzyH3w3E=";
  };

  checkInputs = [
    pytest
    mock
  ];

  meta = with lib; {
    description = "The kitchen sink of Python utility libraries for doing stuff in a functional way. Based on the Lo-Dash Javascript library";
    homepage = https://github.com/dgilland/pydash;
    license = licenses.mit;
  };
}
