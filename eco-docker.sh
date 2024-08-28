#!/bin/bash

C_TITLE="\e[3;33m"
C_ERROR="\e[3;31m"
C_PROCESS="\e[3;35m"
C_FINISH="\e[3;32m"
C_RESET="\e[0m"

if [ "$1" = "" ]; then
    ROUND=0
else
    ROUND=$(($1+1))
fi

echo -e $C_TITLE
echo ""
echo ""
echo "---------------------------------------------------------------------------------"
echo "ROUND ${ROUND}"
echo "---------------------------------------------------------------------------------"
echo ""
echo -e $C_RESET

if [ $ROUND = 0 ]; then
    cat config.json > processing.json;

    python3 make-dockerfile.py

    ERROR=0
    docker build . || ERROR=1

    if [ $ERROR = 1 ]; then
        if [ "$1" = "" ]; then
            echo -e $C_ERROR
            echo ""
            echo "The image does not work";
            echo -e $C_RESET
            exit 1;
        fi
    fi
fi

python3 make-dockerfile.py -1

ERROR=0
docker build . || ERROR=1

if [ $ERROR = 0 ]; then
    python3 decrease-dep.py;
else
    python3 mandatory-dep.py;
fi

ENDED=$(python3 count-to-decrease.py)
echo -e $C_PROCESS
echo "...pending ${ENDED}"
echo -e $C_RESET

if [ $ENDED != 0 ]; then
    ./eco-docker.sh $ROUND
fi

if [ $ROUND = 0 ]; then
    mv processing.json result.json

    echo -e $C_FINISH
    echo ""
    echo "Finished"
    echo -e $C_RESET
fi
