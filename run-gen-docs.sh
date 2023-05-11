#!/bin/sh -uex
echo "Knowl script running to generate ai docs..."

BIN_PATH="$HOME"
WORKING_DIR="$BIN_PATH/knowl_temp"
KNOWL_CODE2DOC_NAME="code2doc.zip"
CODE2DOC_DOWNLOAD_URL='https://releases.knowl.io/code2doc.zip'


get_abs_filename() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [ -z "$1" ]
then
    echo 'no repo path provided'
    exit 0
fi
RESULT_DIR="result"
RESULT_DIR=$(get_abs_filename ${RESULT_DIR})
mkdir -p ${RESULT_DIR}

REPO_PATH=${1}
REPO_PATH=$(get_abs_filename ${REPO_PATH})

verify_wget() {
    BIN_WGET=$(which wget) || {
        echo "You need to install 'wget' to use this hook."
    }
}

verify_unzip() {
    BIN_UNZIP=$(which unzip) || {
        echo "You need to install 'unzip' to use this hook."
    }
}

verify_tmp() {
    touch $BIN_PATH || {
        error_out "Could not write to $BIN_PATH"
    }
}

create_working_dir(){
    working_dir=$1
    if [ ! -d "$working_dir" ]
        then
            mkdir -p -- "$working_dir"
    fi
}


download_from_link() {
    echo "download begins ..."
    echo "$1"
    download_url="$1"
    directory_name="$2"
    file_path="$3"
    
    create_working_dir $directory_name
    $BIN_WGET --no-check-certificate $download_url -O $file_path
    chmod +x $file_path
    echo "download ends ..."

}

check_knowl_cli_version() {
    echo "downloading the latest cli version"
    file_url=$CODE2DOC_DOWNLOAD_URL
    #get folder names in the working directory
    download_from_link $file_url $WORKING_DIR/ $WORKING_DIR/$KNOWL_CODE2DOC_NAME

    export PATH=$PATH:$WORKING_DIR

}

cleanup() {
    echo "Cleaning up..."
}

#machine_type=""
verify_wget
verify_unzip
verify_tmp
check_knowl_cli_version
cd $WORKING_DIR
$BIN_UNZIP $WORKING_DIR/$KNOWL_CODE2DOC_NAME -d $WORKING_DIR
cd s3/code_to_doc
pip install -r requirements.txt
python3.9 python_docs.py -p $REPO_PATH -o $RESULT_DIR
cat $RESULT_DIR/id_to_pages.json
cd ../knowl-utils
npm install -g typescript@4.8.4
npm install --save-dev -g ts-node@10.9.1
npm install --save node-fetch@2.6.2 @types/node-fetch@2.6.2 dotenv cmd-ts http-status-codes
ts-node src/index.ts importer $RESULT_DIR
