{ stdenv, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  name = "cntr-${version}";
  version = "1.2.0";

  src = fetchFromGitHub {
    owner = "Mic92";
    repo = "cntr";
    rev = version;
    sha256 = "0lmbsnjia44h4rskqkv9yc7xb6f3qjgbg8kcr9zqnr7ivr5fjcxg";
  };

  cargoSha256 = "1h5d3zkiy7x0h693c6bnrwsvsc1m9wbzwpndyvyg5zlfi2gqq597";

  meta = with stdenv.lib; {
    description = "A container debugging tool based on FUSE";
    homepage = https://github.com/Mic92/cntr;
    license = licenses.mit;
  };
}
