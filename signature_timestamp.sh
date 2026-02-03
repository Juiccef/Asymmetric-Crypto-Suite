#!/bin/bash

# need file and key or it breaks
f=$1
k=$2

if [ ! -f "$f" ] || [ ! -f "$k" ]; then
    echo "u forgot the file or the key"
    exit 1
fi

# get the time right now
now=$(date +"%Y-%m-%d %H:%M:%S")
echo "signing now: $now"

# make a copy so we dont mess up the original
cp "$f" "$f.signed_tmp"
# stick the time at the bottom
echo "---TIMESTAMP: $now---" >> "$f.signed_tmp"

# do the actual signing part with sha256
openssl dgst -sha256 -sign "$k" -out "$f.sig" "$f.signed_tmp"

echo "done. send the .sig and the .signed_tmp files"
