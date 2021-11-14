{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, portaudio
, swig
, autoreconfHook
, pkg-config
, autoconf-archive
, gfortran
, lapack
, blas
, makeWrapper
, rhasspy-asr-deepspeech-hermes
, rhasspy-asr-kaldi-hermes
, rhasspy-dialogue-hermes
, rhasspy-tts-cli-hermes
, rhasspy-wake-porcupine-hermes
, rhasspy-wake-raven-hermes
, rhasspy-wake-snowboy-hermes
, rhasspy-remote-http-hermes
, rhasspy-fuzzywuzzy-hermes
, rhasspy-speakers-cli-hermes
, rhasspy-microphone-cli-hermes
, rhasspy-microphone-pyaudio-hermes
, rhasspy-homeassistant-hermes
, rhasspy-nlu-hermes
, rhasspy-supervisor
, rhasspy-server-hermes
, supervisor
, mosquitto
, kaldi
, openfst
, opengrm-ngram
, phonetisaurus
, python
, bash
, gawk
, getopt
, coreutils
, gnused
, alsaUtils
, curl
, gzip
, perl
, diffutils
}:

buildPythonPackage rec {
  pname = "rhasspy";
  version = "2.5.11";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-tYNANwEklKaxe5E0dpH+sUAsW3itPmvpROVCwqIrxYM=";
  };

  configureFlags = [
    "RHASSPY_WAKE_SYSTEM=porcupine"
    "RHASSPY_SPEECH_SYSTEM=kaldi,deepspeech"
    "RHASSPY_LANGUAGE=en"
    "--disable-precompiled-binaries"
    "--disable-virtualenv"
    "--disable-wavenet"
  ];

  patches = [
    ./0001-kaldi-don-t-depend-on-atlas.patch
    ./0001-make-mycroft-precise-optional.patch
  ];

  postPatch = ''
    for feat in virtualenv vosk larynx wake_pocketsphinx stt_pocketsphinx; do
       sed -i -e "s/is_''${feat}_enabled=yes/is_''${feat}_enabled=no/g" configure.ac
    done
    # packaged but broken
    sed -i -e '/rhasspy-rasa-nlu-hermes/d' RHASSPY_DIRS RHASSPY_SERVICES
  '';

  postInstall = ''
    install -D -m755 rhasspy.sh $out/bin/rhasspy
    install -D -m755 --target $out/bin bin/*
    mkdir -p $out/share/rhasspy
    cp -r etc $out/share/rhasspy
    wrapProgram $out/bin/rhasspy \
      --prefix PATH : "${lib.makeBinPath [
        supervisor
        rhasspy-dialogue-hermes
        rhasspy-asr-kaldi-hermes
        rhasspy-asr-deepspeech-hermes
        rhasspy-tts-cli-hermes
        rhasspy-wake-porcupine-hermes
        rhasspy-wake-raven-hermes
        rhasspy-wake-snowboy-hermes
        rhasspy-remote-http-hermes
        rhasspy-fuzzywuzzy-hermes
        rhasspy-speakers-cli-hermes
        rhasspy-microphone-cli-hermes
        rhasspy-microphone-pyaudio-hermes
        rhasspy-homeassistant-hermes
        rhasspy-server-hermes
        rhasspy-nlu-hermes
        mosquitto
        kaldi
        openfst
        opengrm-ngram
        phonetisaurus
        bash
        gawk
        getopt
        python
        coreutils
        gnused
        alsaUtils
        curl
        gzip
        perl
        diffutils
      ]}" \
      --set PYTHONPATH "$PYTHONPATH"
     ln -s -t $out/share/rhasspy ${rhasspy-server-hermes}/share/rhasspy/{web,templates}
     mkdir -p $out/lib/kaldi
     ln -s ${kaldi}/bin/* $out/lib/kaldi
     ln -s ${kaldi}/share/kaldi/egs $out/lib/kaldi
  '';

  buildInputs = [
    portaudio
    lapack
    blas
  ];

  nativeBuildInputs = [
    swig
    makeWrapper
    autoreconfHook
    pkg-config
    autoconf-archive
    gfortran
  ];

  propagatedBuildInputs = [
    rhasspy-dialogue-hermes
    rhasspy-asr-deepspeech-hermes
    rhasspy-asr-kaldi-hermes
    rhasspy-tts-cli-hermes
    rhasspy-wake-raven-hermes
    rhasspy-wake-porcupine-hermes
    rhasspy-remote-http-hermes
    rhasspy-fuzzywuzzy-hermes
    rhasspy-speakers-cli-hermes
    rhasspy-microphone-cli-hermes
    rhasspy-microphone-pyaudio-hermes
    rhasspy-homeassistant-hermes
    rhasspy-server-hermes
    rhasspy-nlu-hermes
    rhasspy-supervisor
  ];

  meta = with lib; {
    description = "Combination of multiple Rhasspy services running together";
    homepage = "https://github.com/rhasspy/rhasspy";
    license = licenses.mit;
    maintainers = [ maintainers.mic92 ];
  };
}
