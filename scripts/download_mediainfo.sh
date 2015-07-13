app="MediaInfo"

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $DIR/settings.sh

version_regex="(\d+\.\d+\.\d+)"
filename=$(
    curl -kL "https://mediaarea.net/en/MediaInfo" 2>&1 | \
    grep -oP "MediaInfo_GUI_${version_regex}_Windows\.exe"
)
version=$(echo $filename | grep -oP "$version_regex")
dl_url=http://mediaarea.net/download/binary/mediainfo-gui/$version/$filename

downloadFile "aria2c" "$app" "$filename" "$dl_url" "$version"
