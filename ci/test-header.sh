set -e

echo -e "\nStarting the build..."

finish () {
    echo -e "\n\033[31mBuild NOT successfull\e[0m"
    exit $1
}

trap finish EXIT SIGHUP SIGINT SIGTERM
