#!/bin/bash
FILE=MedDreamViewer-7.1.1.zip
if [ ! -f "$FILE" ]; then
    echo "$FILE does not exist, downloading"
    wget https://www.softneta.com/files/meddreamviewer/711/MedDreamViewer-7.1.1.zip
fi
IMAGENAME="meddream"
echo "Building docker image: $IMAGENAME"
docker build -t $IMAGENAME .
