{ stdenv, python3, fetchzip }:
stdenv.mkDerivation {
  pname = "healthcheck";
  version = "2020-02-20";
  src = fetchzip {
    url = "https://gist.github.com/Mic92/b2ebb4790db65d686d608c6875281dbf/archive/91a8cc7353f2834cdcbb0164060886a6c9a42d24.tar.gz";
    sha256 = "1yjv2jqvmc2v79y63hw2jhyhls94nbj9g1ks0a2z5785niga57zy";
  };
  buildInputs = [ python3 ];
  installPhase = ''
    install -D -m 755 healthcheck.py $out/bin/healthcheck
  '';
  meta = with stdenv.lib; {
    description = "Healtcheck for icingamaster.bsd.services";
    homepage = https://gist.github.com/Mic92/b2ebb4790db65d686d608c6875281dbf;
    license = licenses.mit;
    platforms = platforms.all;
  };
}
