{ stdenv, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage {
  name = "cntr-2018-06-15";

  src = fetchFromGitHub {
    owner = "Mic92";
    repo = "cntr";
    rev = "967464a69ef5559a9aff2b7aa564ab53d35e4889";
    sha256 = "13qid4qgbg9ybm5n64bbqhaj49gpsic0cvacrqsmfakvc1m1bmmg";
  };

  cargoSha256 = "1h5d3zkiy7x0h693c6bnrwsvsc1m9wbzwpndyvyg5zlfi2gqq597";

  meta = with stdenv.lib; {
    description = "A container debugging tool based on FUSE";
    homepage = https://github.com/Mic92/cntr;
    license = licenses.mit;
  };
}
