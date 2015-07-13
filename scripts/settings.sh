dir_curr=`bin/pwd.exe`
prj_root="$dir_curr"

export dir_bin=$prj_root/bin
export dir_build=$prj_root/build
export dir_downloads=$prj_root/downloads
export dir_filelists=$prj_root/filelists
export dir_logs=$prj_root/logs
export dir_patch=$prj_root/patch
export dir_scripts=$prj_root/scripts
export dir_tmp=$prj_root/tmp

export PATH=$dir_bin

mkdir -p $dir_build
mkdir -p $dir_downloads
mkdir -p $dir_filelists
mkdir -p $dir_logs
mkdir -p $dir_tmp


DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source $DIR/functions.sh
