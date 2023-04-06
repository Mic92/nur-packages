{ lib, buildPythonPackage, fetchPypi }:

buildPythonPackage rec {
  pname = "remote-pdb";
  version = "2.1.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-LXDG9B4Oq/AWXo8b5Y+CqnpgWq6rjyrv65ziRkMQkcE=";
  };

  meta = with lib; {
    description = "Remote vanilla PDB (over TCP sockets) done right: no extras, proper handling around connection failures and CI";
    homepage = "https://github.com/ionelmc/python-remote-pdb";
    license = licenses.bsd2;
  };
}
