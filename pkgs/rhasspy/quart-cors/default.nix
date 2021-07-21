{ lib
, buildPythonPackage
, fetchPypi
, quart
, pythonOlder
, pytest
, pytest-asyncio
}:

buildPythonPackage rec {
  pname = "quart-cors";
  version = "0.5.0";

  disabled = pythonOlder "3.7"; # requires python version >=3.7.0

  src = fetchPypi {
    pname = "Quart-CORS";
    inherit version;
    sha256 = "sha256-6gjSau+RjVkZT78GXN6bbK6Q3F8hEg3NJU19RhkM0pM=";
  };

  propagatedBuildInputs = [
    quart
  ];

  checkInputs = [
    pytest
    pytest-asyncio
  ];

  meta = with lib; {
    description = "A Quart extension to provide Cross Origin Resource Sharing, access control, support";
    homepage = https://gitlab.com/pgjones/quart-cors/;
    license = licenses.mit;
    # maintainers = [ maintainers. ];
  };
}
