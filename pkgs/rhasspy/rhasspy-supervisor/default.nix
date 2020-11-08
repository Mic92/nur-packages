{ lib
, buildPythonPackage
, fetchFromGitHub
, rhasspy-profile
, pyyaml
}:

buildPythonPackage rec {
  pname = "rhasspy-supervisor";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "rhasspy";
    repo = "rhasspy-supervisor";
    rev = "v${version}";
    sha256 = "1nsz5vj6y6k0d085k9a082xk2jas98i8m6cpkzaqmamnsd0qaz19";
  };

  propagatedBuildInputs = [
    rhasspy-profile
    pyyaml
  ];

  postPatch = ''
    patchShebangs ./configure
    sed -i "s/pyyaml==.*/pyyaml/" requirements.txt
  '';

  meta = with lib; {
    description = "Tool for generating supervisord configurations from Rhasspy profile";
    homepage = "https://github.com/rhasspy/rhasspy-supervisor";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
