{ stdenv, fetchFromGitHub, mbuild }:

stdenv.mkDerivation {
  name = "xed-2018-06-19";

  src = fetchFromGitHub {
    owner = "intelxed";
    repo = "xed";
    rev = "9c6867252545d5a696dda0ca2d622901dcee4aa8";
    sha256 = "0pzq3xxq56sp207n8sv5slsns5cjip8xl34fyydvi3ivsj8h3kyr";
  };

  installPhase = ''
    python ./mfile.py install --shared --install-dir=$out
    ln -s $out/include/xed/* $out/include
    rm -r $out/{mbuild,misc,LICENSE,examples}
  '';

  nativeBuildInputs = [
    mbuild
  ];

  meta = with stdenv.lib; {
    description = "x86 encoder decoder";
    homepage = https://github.com/intelxed/xed;
    license = lib.licenses.apsl20;
  };
}
