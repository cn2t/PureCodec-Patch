app="KMPlayer"

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $DIR/settings.sh

version_regex="(\d+\.\d+\.\d+\.\d+_\d+)"
filename=$(
    curl -kL "http://www.videohelp.com/software/KMPlayer" 2>&1 | \
    grep -oP "$version_regex\.exe"
)

version=$(echo $filename | grep -oP "$version_regex")
dl_url=http://cdn.kmplayer.com/KMP/player/download/install/$filename

downloadFile "curl" "$app" "$filename" "$dl_url" "$version"
