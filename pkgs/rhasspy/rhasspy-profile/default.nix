{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, pydash
, aiofiles
, aiohttp
, json5
}:

buildPythonPackage rec {
  pname = "rhasspy-profile";
  version = "0.5.3";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "rhasspy";
    repo = "rhasspy-profile";
    rev = "v${version}";
    sha256 = "1vqr51kiqh4wkgvkkr86qy0dclgfxqzxpxmfyg15lh4fcppwq1rg";
  };

  postPatch = ''
    patchShebangs ./configure
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
