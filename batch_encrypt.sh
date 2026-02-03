#!/bin/bash

# Check if the public key file was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: ./batch_encrypt.sh <public_key.pem>"
    exit 1
fi

PUB_KEY=$1

# Loop through all .txt files in the current directory
for file in *.txt; do
    # Prevent errors if no .txt files exist
    [ -e "$file" ] || continue

    echo "Encrypting $file..."

    # Use openssl pkeyutl for the encryption process
    openssl pkeyutl -encrypt -pubin -inkey "$PUB_KEY" -in "$file" -out "${file}.enc"

    if [ $? -eq 0 ]; then
        echo "Done: ${file}.enc created."
    else
        echo "Error: Could not encrypt $file."
    fi
done
