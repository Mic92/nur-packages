{ lib
, python3
, fetchFromGitHub
, bing-image-creator
}:

python3.pkgs.buildPythonPackage rec {
  pname = "edge-gpt";
  version = "0.7.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "acheong08";
    repo = "EdgeGPT";
    rev = version;
    hash = "sha256-W8I9VwABXRgqAoF4y6svV0gLxuP1yN9GoASyOTbocrM=";
  };

  postPatch = ''
    # we don't need the socks feature
    sed -i -e 's/httpx.*>=[^"]+/httpx/g' setup.py
  '';

  propagatedBuildInputs = with python3.pkgs; [
    requests
    aiofiles
    certifi
    httpx
    rich
    websockets
    prompt-toolkit
    bing-image-creator
  ];


  pythonImportsCheck = [
    "EdgeGPT"
    "ImageGen"
  ];

  meta = with lib; {
    description = "Reverse engineered API of Microsoft's Bing Chat AI";
    homepage = "https://github.com/acheong08/EdgeGPT";
    license = licenses.unlicense;
  };
}
