source ./scripts/settings.sh

$dir_scripts/download_lavfilters.sh
$dir_scripts/download_madvr.sh
$dir_scripts/download_mediainfo.sh
$dir_scripts/download_mpc-hc.sh
$dir_scripts/download_potplayer.sh
$dir_scripts/download_kmplayer.sh
cleanOldDownloads

rm -rf $dir_tmp $dir_build
mkdir -p $dir_tmp $dir_build

for f in $dir_logs/*.log; do
    filename=$(getJsonPropertyFromFile $f "filename")
    filename=${filename//\"/}
    filenameNoExt=${filename%.*}
    downloadedFile="$dir_downloads/$filename"
    decompressDir=$dir_tmp/$filenameNoExt
    if [[ -f $downloadedFile ]]; then
        7z x -y -o"$decompressDir" "$downloadedFile"
        app=$(getJsonPropertyFromFile $f "app")
        app=${app//\"/}
        filelist="$dir_filelists/$app.json"
        if [[ -f $filelist ]]; then
            files=$(
                cat $filelist | \
                $dir_scripts/JSON.sh -b
            )
            files=${files//[\[\]\"]/}
            readarray -t files <<< "$files"
            for i in $(seq 0 1 ${#files[@]}); do
                fileFrom=$(echo ${files[$i]} | awk '{print $1}')
                fileFrom=$(echo $fileFrom | sed "s/\$filenameNoExt/$filenameNoExt/g")
                fileTo=$(echo ${files[$i]} | awk '{print $2}')
                mkdir -p $(dirname "$dir_build/$fileTo")
                if [[ -n "$fileFrom" ]]; then
                    mv -f "$decompressDir/$fileFrom" "$dir_build/$fileTo"
                fi
            done
        fi
    else
        echo -e ${BRed}"'$dir_downloads/$filename'" not exists...${Color_Off}
    fi
done

mkdir -p $dir_build/Main
mv $dir_build/* $dir_build/Main
cp -r $dir_patch/* $dir_build
echoAllVersion > $dir_build/version.log
rm -rf PureCodec*

packageName="PureCodec-Patch-v$(date +%y%m%d)"
mv $dir_build $packageName
7z a $packageName.exe -t7z -m0=lzma2 -mx=9 -mfb=64 -md=64m -ms=on -sfx7z.sfx $packageName

rm -rf $dir_tmp $packageName

echo -e ${BGreen}Done!! Please check $packageName.exe${Color_Off}
