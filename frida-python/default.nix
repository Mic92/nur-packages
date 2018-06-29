{ stdenv, python3, fetchurl }:


with python3.pkgs;

buildPythonPackage rec {
  pname = "frida";
  version = "11.0.13";

  # building is somewhat complicated, described in https://nixos.wiki/wiki/Frida
  src = fetchurl {
    url = "https://dl.thalheim.io/0wWmCbPcE3RJ2-C-o3pLuw/frida-${version}-py3.6-linux-x86_64.egg";
    sha256 = "02ik3ygbfv0k5d7iw4i79fs91q6bxm72f8daswq9n1x960kpp9r4";
  };

  unpackPhase = ":";

  format = "other";

  propagatedBuildInputs = [ pygments prompt_toolkit colorama ];

  installPhase = ''
    dest=$out/lib/${python3.libPrefix}/site-packages
    export PYTHONPATH=$PYTHONPATH:$dest
    mkdir -p $dest
    easy_install --prefix $out $src
  '';

  meta = with stdenv.lib; {
    description = "Dynamic instrumentation toolkit for developers, reverse-engineers, and security researchers";
    homepage = https://www.frida.re/;
    license = licenses.wxWindows;
  };
}


