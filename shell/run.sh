#!/bin/bash

N_JOBS=8

if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 <domain-file> <image-dir> [n-jobs]"
    exit 1
else
    DOMAINFILE="$1"
    IMAGEDIR=$(cd "$2"; pwd)    # Get absolute path
    echo "Using domains from $DOMAINFILE and putting images in $IMAGEDIR"
fi

if [[ -z "$3" ]]; then
    N_JOBS=8
else
    N_JOBS="$3"
fi

mkdir -p "$IMAGEDIR"

for DOMAIN in $(cut -d, -f2 $DOMAINFILE | head -10000); do
    echo "Running on $DOMAIN"
    sudo docker run -t --rm -v $IMAGEDIR:/raster-output herzog31/rasterize "http://$DOMAIN" "$DOMAIN.png" 1200px*800px 1.0 &

    NPROC=$(($NPROC+1))
    if [ "$NPROC" -ge "$N_JOBS" ]; then
        wait
        NPROC=0
    fi
done;
