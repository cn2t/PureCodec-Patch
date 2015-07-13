app="PotPlayer"

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $DIR/settings.sh

version_regex="(\d+\.\d+\.\d+)"
filename=$(
    curl -kL "http://www.videohelp.com/software/PotPlayer" 2>&1 | \
    grep -oP "PotPlayerSetup-$version_regex\.exe" | \
    tr '\n' ' ' | \
    xargs
)

# get the last element
# if there is only one element, it's a stable release
# if there is two elements, the last one is dev release
filename=${filename##* }

version=$(echo $filename | grep -oP "$version_regex")
dl_url=http://www.videohelp.com/download/$filename

downloadFile "aria2c" "$app" "$filename" "$dl_url" "$version"
