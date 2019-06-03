set -e

finish () {
    exit $1
}

if [[ -z $PROJECTS_CACHE_DIR_BASE && $(whoami) == 'vagrant' ]]; then
    PROJECTS_CACHE_DIR_BASE="/home/vagrant/.projects_cache"
fi

if [[ -z $PROJECTS_CACHE_DIR ]]; then
    PROJECTS_CACHE_DIR=${PROJECTS_CACHE_DIR_BASE}/$(id -u)
fi

trap finish EXIT SIGHUP SIGINT SIGTERM
