set -e

finish () {
    exit $1
}

trap finish EXIT SIGHUP SIGINT SIGTERM
