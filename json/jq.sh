#!/bin/bash

###                    ###
#   通过jq处理json格式   #
###                    ###

# define strings variable
PGDB=test
PGUSER=user
PGPASSWORD=123456

DATA='
{
    "postgres": {
        "imageName": "postgres:latest",
        "env": "POSTGRES_DB=${PGDB},POSTGRES_USER=${PGUSER},POSTGRES_PASSWORD=${PGPASSWORD}",
        "port": "5432:5432",
        "volume": "",
        "otherArgs": "",
        "cmd": ""
    }
}'

# download jq to /usr/bin
jq --help &>/dev/null
if [ $? -ne 0 ];then
    curl -fSL  https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o /usr/bin/jq
chmod +x /usr/bin/jq
fi

Name=postgres
Image=$(echo $DATA |eval jq '.\"${Name}\".imageName' |tr -d '"')
Env=`eval echo $(echo $DATA |eval jq '.\"${Name}\".env' |tr -d '"')`

echo "Image: ${Image}"
echo "Env: ${Env}"
