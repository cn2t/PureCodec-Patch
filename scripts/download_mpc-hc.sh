app="MPC-HC"

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $DIR/settings.sh

version_regex="(\d+\.\d+.\d+\.\d+)"
filename=$(
    curl -kLd "action=get&items=true&itemsHref=%2F&itemsWhat=1" "https://nightly.mpc-hc.org" 2>&1 | \
    grep -oP "log\.$version_regex\.log"
)
version=$(echo $filename | grep -oP "$version_regex")

filename="MPC-HC.$version.x86.7z"
dl_url=https://nightly.mpc-hc.org/$filename
downloadFile "aria2c" "$app" "$filename" "$dl_url" "$version"

app="MPC-HC_standalone_filters"
filename="MPC-HC_standalone_filters.$version.x86.7z"
dl_url=https://nightly.mpc-hc.org/$filename
downloadFile "aria2c" "$app" "$filename" "$dl_url" "$version"
