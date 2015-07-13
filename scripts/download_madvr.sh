app="madVR"

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $DIR/settings.sh

version_regex="(\d+)"
filename=$(
    curl -kL "http://www.videohelp.com/software/madVR" 2>&1 | \
    grep -oP "madVR$version_regex\.zip"
)
version=$(echo $filename | grep -oP "$version_regex" | sed -r "s/([0-9])([0-9][0-9])([0-9][0-9])/\1.\2.\3/g")
dl_url=http://www.videohelp.com/download/$filename

downloadFile "aria2c" "$app" "$filename" "$dl_url" "$version"
