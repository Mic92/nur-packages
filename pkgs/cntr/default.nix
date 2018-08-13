{ stdenv, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  name = "cntr-${version}";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "Mic92";
    repo = "cntr";
    rev = version;
    sha256 = "13qid4qgbg9ybm5n64bbqhaj49gpsic0cvacrqsmfakvc1m1bmm0";
  };

  cargoSha256 = "1h5d3zkiy7x0h693c6bnrwsvsc1m9wbzwpndyvyg5zlfi2gqq597";

  meta = with stdenv.lib; {
    description = "A container debugging tool based on FUSE";
    homepage = https://github.com/Mic92/cntr;
    license = licenses.mit;
  };
}
