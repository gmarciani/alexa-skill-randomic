#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

BUILD_DIR="${ROOT_DIR}/build"
LAMBDA_SRC_DIR="${ROOT_DIR}/lambda/py"
LAMBDA_OUT_DIR="${BUILD_DIR}/out"
LAMBDA_OUT_FILE="${BUILD_DIR}/lambda.zip"

PROFILE="gmarciani-developer"
S3_PATH="s3://gmarciani.alexa.randomic/lambda.zip"

mkdir ${BUILD_DIR}
mkdir ${LAMBDA_OUT_DIR}

pip install -r ${LAMBDA_SRC_DIR}/requirements.txt -t ${LAMBDA_OUT_DIR} 

cp ${LAMBDA_SRC_DIR}/* ${LAMBDA_OUT_DIR}/

cd ${LAMBDA_OUT_DIR}
zip -r ${LAMBDA_OUT_FILE} *
cd ${ROOT_DIR}

aws s3 --profile ${PROFILE} cp ${LAMBDA_OUT_FILE} ${S3_PATH}  
