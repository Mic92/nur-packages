{ lib
, stdenv
, writeScriptBin
, coreutils
, gawk
, gnused
, netcat
, nettools
}:

(writeScriptBin "irc-announce" ''
  #!${stdenv.shell}
  set -euf

  export PATH=${lib.makeSearchPath "bin" ([
    coreutils
    gawk
    gnused
    netcat
    nettools
  ])}

  IRC_SERVER=$1
  IRC_PORT=$2
  IRC_NICK=$3$$
  IRC_CHANNEL=$4
  IRC_TLS=$5
  message=$6

  export IRC_CHANNEL # for privmsg_cat

  # echo2 and cat2 are used output to both, stdout and stderr
  # This is used to see what we send to the irc server. (debug output)
  echo2() { echo "$*"; echo "$*" >&2; }
  cat2() {
    awk '{
      print $0
      print $0 > "/dev/stderr"
    }'
  }

  # privmsg_cat transforms stdin to a privmsg
  privmsg_cat() { awk '{ print "PRIVMSG "ENVIRON["IRC_CHANNEL"]" :"$0 }'; }

  tls_flag() { if [[ "$IRC_TLS" == 1 ]]; then echo "-c"; fi }

  # ircin is used to feed the output of netcat back to the "irc client"
  # so we can implement expect-like behavior with sed^_^
  # XXX mkselfdestructingtmpfifo would be nice instead of this cruft
  tmpdir=$(mktemp --tmpdir -d irc-announce_XXXXXXXX)
  cd "$tmpdir"
  mkfifo ircin
  trap "
    rm ircin
    cd '$OLDPWD'
    rmdir '$tmpdir'
    trap - EXIT INT QUIT
  " EXIT INT QUIT

  {
    echo2 "USER $LOGNAME 0 * :$LOGNAME@$(hostname)"
    echo2 "NICK $IRC_NICK"

    awk 'match($0, /PING(.*)/, m) {print "PONG", m[1]; exit}'

    # wait for MODE message
    sed -n '/^:[^ ]* MODE /q'

    echo2 "JOIN $IRC_CHANNEL"

    printf '%s' "$message" \
      | privmsg_cat \
      | cat2

    echo2 "PART $IRC_CHANNEL"

    # wait for PART confirmation
    sed -n '/:'"$IRC_NICK"'![^ ]* PART /q'

    echo2 'QUIT :Gone to have lunch'
  } < ircin \
    | nc $(tls_flag) "$IRC_SERVER" "$IRC_PORT" | tee -a ircin
'') // {
  meta = {
    description = "IRC notifications implemented in ~25 lines shell script";
  };
}
