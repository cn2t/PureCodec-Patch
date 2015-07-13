app="LAVFilters"

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $DIR/settings.sh

version_regex="(\d+\.\d+-\d+-git-r\d+\([\da-f]+\))"
filename=$(
    curl -kLd "action=get&items=true&itemsHref=%2FLAVFilters%2F&itemsWhat=1" "http://tmod.nmm-hd.org/LAVFilters" 2>&1 | \
    grep -oP "LAVFilters-$version_regex\.7z"
)
version=$(echo $filename | grep -oP "$version_regex")
dl_url=http://tmod.nmm-hd.org/LAVFilters/$filename

downloadFile "aria2c" "$app" "$filename" "$dl_url" "$version"
