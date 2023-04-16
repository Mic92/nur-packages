{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonApplication rec {
  pname = "bing-image-creator";
  version = "0.1.2.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "acheong08";
    repo = "BingImageCreator";
    rev = version;
    hash = "sha256-p4a6LKceGTDMUOG7Ic7OypwZvtlBMo0tVvKS/lKgCo8=";
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
    maintainers = with maintainers; [ ];
  };
}
