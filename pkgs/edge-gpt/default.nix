{ lib
, python3
, fetchFromGitHub
, runtimeShell
}:

python3.pkgs.buildPythonApplication rec {
  pname = "edge-gpt";
  version = "0.1.23";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "acheong08";
    repo = "EdgeGPT";
    rev = version;
    hash = "sha256-MdVV7S5T8Alo9u0+k5PV22M98EM09rBcJKsBioc/QAI=";
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
    maintainers = with maintainers; [ ];
  };
}
