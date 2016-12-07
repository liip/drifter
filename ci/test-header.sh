set -e

finish () {
    exit $1
}

trap finish EXIT SIGHUP SIGINT SIGTERM

# read variables set by drifter into the environment (they're not set, if not called from bash)
. /etc/profile.d/drifter_vars.sh
