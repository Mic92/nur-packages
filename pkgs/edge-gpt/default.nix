{ lib
, python3
, fetchFromGitHub
}:

python3.pkgs.buildPythonApplication rec {
  pname = "edge-gpt";
  version = "0.1.24.1";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "acheong08";
    repo = "EdgeGPT";
    rev = version;
    hash = "sha256-oDUeNGrcEzofNNULJnnRrDZ1HP7EnoE4DUqzv9WE5yM=";
  };

  propagatedBuildInputs = with python3.pkgs; [
    requests
    certifi
    httpx
    rich
    websockets
    regex
    prompt-toolkit
    (callPackage ./bing-image-creator { })
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
