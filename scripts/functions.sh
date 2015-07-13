# downloadFile($downloader, $app, $filename, $dl_url, $version)
downloadFile () {
    downloader=$1
    app=$2
    filename=$3
    dl_url=$4
    version=$5

    # debug messages
    if false; then
        appMsg $app "${BCyan}downloadFile - debug start${Color_Off}"
        appMsg $app "downloader=$downloader"
        appMsg $app "app=$app"
        appMsg $app "filename=$filename"
        appMsg $app "dl_url=$dl_url"
        appMsg $app "version=$version"
        appMsg $app "${BCyan}downloadFile - debug end${Color_Off}"
    fi

    dl_ok=0
    appMsg $app "Downloading $app $version"
    appMsg $app "from $dl_url"

    if [[ -f "$dir_downloads/$filename" ]]; then
        dl_ok=1
        appMsg $app "$dir_downloads/$filename alreay exists..."
        appMsg $app "${BGreen}No need to download.${Color_Off}"
    else
        referer=${dl_url%/*}
        if [[ "$downloader" == "aria2c" ]]; then
            aria2c --split=16 --max-connection-per-server=16 --min-split-size=1M --dir="$dir_tmp" --referer="$referer" "$dl_url"
        elif [[ "$downloader" == "curl" ]]; then
            curl -L -o "$dir_tmp/$filename" "$dl_url"
        fi
        if [[ -f "$dir_tmp/$filename" ]]; then
            dl_ok=1
            mv "$dir_tmp/$filename" "$dir_downloads"
            appMsg $app "${BGreen}Download successfully!${Color_Off}"
        else
            appMsg $app "$dir_tmp/$filename not found..."
            appMsg $app "${BRed}Download failed!${Color_Off}"
        fi
    fi

    if [[ "$dl_ok" == "1" ]]; then
        echo $(appInfoJson $app $filename $version) > "$dir_logs/$app.log"
    fi
}

# appMsg($app, $msg)
appMsg () {
    app=$1
    msg=$2
    echo -e "${BYellow}[$app]${Color_Off} $msg"
}

# appInfoJson($app, $filename, $version)
appInfoJson () {
    app=$1
    filename=$2
    version=$3
    echo "{
        \"app\"      : \"$app\",
        \"filename\" : \"$filename\",
        \"version\"  : \"$version\"
    }"
}

cleanOldDownloads () {
    tmpDir=$dir_tmp/_tmp_
    mkdir -p $tmpDir
    for f in $dir_logs/*.log; do
        filename=$(getJsonPropertyFromFile $f "filename")
        filename=${filename//\"/}
        if [[ -f "$dir_downloads/$filename" ]]; then
            mv "$dir_downloads/$filename" "$tmpDir"
        fi
    done
    rm -rf $dir_downloads/*
    mv $tmpDir/* $dir_downloads
    rm -rf $tmpDir
}

echoAllVersion () {
    for f in $dir_logs/*.log; do
        app=$(getJsonPropertyFromFile $f "app")
        version=$(getJsonPropertyFromFile $f "version")
        out="$app: $version"
        echo ${out//\"/}
    done
    echo
    echo http://2d-gate.org
}

# getJsonPropertyFromFile($file, $property)
getJsonPropertyFromFile () {
    file=$1
    property=$2
    echo $(
        cat $file | \
        $dir_scripts/JSON.sh -b | \
        grep -oP "^\[\"$property\"\].*" | \
        cut -f2
    )
}

###############
# color table #
###############
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# Reset
Color_Off='\e[0m'      # Text Reset
# Regular Colors
Black='\e[0;30m'       # Black
Red='\e[0;31m'         # Red
Green='\e[0;32m'       # Green
Yellow='\e[0;33m'      # Yellow
Blue='\e[0;34m'        # Blue
Purple='\e[0;35m'      # Purple
Cyan='\e[0;36m'        # Cyan
White='\e[0;37m'       # White
# Bold
BBlack='\e[1;30m'      # Black
BRed='\e[1;31m'        # Red
BGreen='\e[1;32m'      # Green
BYellow='\e[1;33m'     # Yellow
BBlue='\e[1;34m'       # Blue
BPurple='\e[1;35m'     # Purple
BCyan='\e[1;36m'       # Cyan
BWhite='\e[1;37m'      # White
# Underline
UBlack='\e[4;30m'      # Black
URed='\e[4;31m'        # Red
UGreen='\e[4;32m'      # Green
UYellow='\e[4;33m'     # Yellow
UBlue='\e[4;34m'       # Blue
UPurple='\e[4;35m'     # Purple
UCyan='\e[4;36m'       # Cyan
UWhite='\e[4;37m'      # White
# Background
On_Black='\e[40m'      # Black
On_Red='\e[41m'        # Red
On_Green='\e[42m'      # Green
On_Yellow='\e[43m'     # Yellow
On_Blue='\e[44m'       # Blue
On_Purple='\e[45m'     # Purple
On_Cyan='\e[46m'       # Cyan
On_White='\e[47m'      # White
# High Intensity
IBlack='\e[0;90m'      # Black
IRed='\e[0;91m'        # Red
IGreen='\e[0;92m'      # Green
IYellow='\e[0;93m'     # Yellow
IBlue='\e[0;94m'       # Blue
IPurple='\e[0;95m'     # Purple
ICyan='\e[0;96m'       # Cyan
IWhite='\e[0;97m'      # White
# Bold High Intensity
BIBlack='\e[1;90m'     # Black
BIRed='\e[1;91m'       # Red
BIGreen='\e[1;92m'     # Green
BIYellow='\e[1;93m'    # Yellow
BIBlue='\e[1;94m'      # Blue
BIPurple='\e[1;95m'    # Purple
BICyan='\e[1;96m'      # Cyan
BIWhite='\e[1;97m'     # White
# High Intensity backgrounds
On_IBlack='\e[0;100m'  # Black
On_IRed='\e[0;101m'    # Red
On_IGreen='\e[0;102m'  # Green
On_IYellow='\e[0;103m' # Yellow
On_IBlue='\e[0;104m'   # Blue
On_IPurple='\e[0;105m' # Purple
On_ICyan='\e[0;106m'   # Cyan
On_IWhite='\e[0;107m'  # White
