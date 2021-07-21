{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
}:

buildPythonPackage rec {
  pname = "rapidfuzz";
  version = "1.4.1";

  disabled = pythonOlder "3.5";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-3iBVAXg3bSG/4bNKfcQqsQe7KC74IGnPbf4oBaACniY=";
  };

  meta = with lib; {
    description = "Rapid fuzzy string matching";
    homepage = "https://github.com/maxbachmann/rapidfuzz";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
