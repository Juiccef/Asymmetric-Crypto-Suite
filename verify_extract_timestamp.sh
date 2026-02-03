#!/bin/bash

# 1=file, 2=sig, 3=pubkey
sf=$1
sig=$2
pk=$3

if [ ! -f "$sf" ] || [ ! -f "$sig" ] || [ ! -f "$pk" ]; then
    echo "missing something... need file, sig, and pubkey"
    exit 1
fi

# check if the math matches
echo "checking sig..."
res=$(openssl dgst -sha256 -verify "$pk" -signature "$sig" "$sf" 2>&1)

if [[ "$res" == *"Verified OK"* ]]; then
    echo "✅ looks good"
    
    # find the timestamp we hid in there
    ts=$(grep -oE "\-\-\-TIMESTAMP: .* \-\-\-" "$sf" | sed 's/---TIMESTAMP: //;s/---//')
    echo "signed at: $ts"
else
    echo "❌ bad sig. someone messed with the file"
    exit 1
fi
