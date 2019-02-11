#!/bin/bash
DOCDIR=${DOCDIR:-"/opt/docs"}
PORT=${PORT:-8000}

main() {
    cd $DOCDIR
    MODE=${0##*/}

    case "$MODE" in
    produce)
      produce ;;
    serve)
      serve ;;
    *)
      >&2 echo "Error: Invalid Option.  Script can be called with serve or produce" ;;
    esac  
}

produce() {
  mkdocs build
  tar czf /tmp/output.tar.gz site
  cat /tmp/output.tar.gz
}

serve() {
  mkdocs serve -a 0.0.0.0:$PORT
}

main