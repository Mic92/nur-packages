{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchpatch
, pythonOlder
, rhasspy-hermes
, rhasspy-profile
, rhasspy-nlu
, swagger-ui-py
, rhasspy-supervisor
, quart
, quart-cors
}:

buildPythonPackage rec {
  pname = "rhasspy-server-hermes";
  version = "2.5.5";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "rhasspy";
    repo = pname;
    rev = "a731c2602f87f3ebdc843edcc51d457fde3d4b59";
    sha256 = "sha256-4vPKtqtT5rwXEA0kGRnz9DdDsF47fOEzvK/r72U5Pyc=";
  };

  postPatch = ''
    sed -i "s/swagger-ui-py==.*/swagger-ui-py/" requirements.txt
    sed -i "s/quart==.*/quart/" requirements.txt
  '';

  propagatedBuildInputs = [
    rhasspy-hermes
    rhasspy-profile
    rhasspy-nlu
    swagger-ui-py
    rhasspy-supervisor
    quart
    quart-cors
  ];

  postInstall = ''
    mkdir -p $out/share/rhasspy
    cp -r templates $out/share/rhasspy/templates
    cp -r web $out/share/rhasspy/web
  '';

  doCheck = false;

  meta = with lib; {
    description = "Web server interface to Rhasspy with Hermes back-end";
    homepage = "https://github.com/rhasspy/rhasspy-server-hermes";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
