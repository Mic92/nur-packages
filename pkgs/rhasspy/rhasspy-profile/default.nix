{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, pydash
, aiofiles
, aiohttp
, json5
, python
, dataclasses-json
}:

buildPythonPackage rec {
  pname = "rhasspy-profile";
  version = "0.4.0";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "rhasspy";
    repo = "rhasspy-profile";
    rev = "v${version}";
    sha256 = "sha256-I6ThrOfZHvpkcQSugw+dtVrUX79qqBPkcC/uTiohulY=";
  };

  postPatch = ''
    patchShebangs ./configure
    sed -i "s/aiohttp==.*/aiohttp/" requirements.txt
    sed -i "s/aiofiles==.*/aiofiles/" requirements.txt
    sed -i "s/json5==.*/json5/" requirements.txt
  '';

  postInstall = ''
    cp -r rhasspyprofile/profiles $out/${python.sitePackages}/rhasspyprofile
  '';

  propagatedBuildInputs = [
    pydash
    aiofiles
    aiohttp
    json5
    dataclasses-json
  ];

  meta = with lib; {
    description = "Python library for Rhasspy settings";
    homepage = "https://github.com/rhasspy/rhasspy-profile";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
