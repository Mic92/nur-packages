{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonApplication rec {
  pname = "bing-image-creator";
  version = "0.1.3";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "acheong08";
    repo = "BingImageCreator";
    rev = version;
    hash = "sha256-tsPUKlgZM478TR863PCUmlzInaHSAXOi4zBfkz3TT0s=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    regex
    requests
    aiohttp
  ];

  pythonImportsCheck = [ "BingImageCreator" ];

  meta = with lib; {
    description = "High quality image generation by Microsoft. Reverse engineered API";
    homepage = "https://github.com/acheong08/BingImageCreator";
    license = licenses.unlicense;
  };
}
