{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
, pydash
, aiofiles
, aiohttp
, json5
}:

buildPythonPackage rec {
  pname = "rhasspy-profile";
  version = "0.1.4";

  disabled = pythonOlder "3.6";

  src = fetchPypi {
    inherit pname version;
    sha256 = "d22313dcd3e024cc90a6ec32fe486d769d773092e6c071e4358df66e177aee17";
  };

  postPatch = ''
    sed -i "s/aiofiles==.*/aiofiles/" requirements.txt
    sed -i "s/json5==.*/json5/" requirements.txt
  '';

  propagatedBuildInputs = [
    pydash
    aiofiles
    aiohttp
    json5
  ];

  meta = with lib; {
    description = "Python library for Rhasspy settings";
    homepage = "https://github.com/rhasspy/rhasspy-profile";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
