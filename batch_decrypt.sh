#!/bin/bash

# Check if the private key file was provided as an argument
if [ -z "$1" ]; then
    echo "Usage: ./batch_decrypt.sh <private_key.pem>"
    exit 1
fi

PRIV_KEY=$1

# Loop through all .enc files in the current directory
for file in *.enc; do
    # Prevent errors if no .enc files exist
    [ -e "$file" ] || continue

    # Create the new filename: originalname.decrypted.txt
    # This removes the .enc and adds .decrypted.txt
    output_file="${file%.enc}.decrypted.txt"

    echo "Decrypting $file..."

    # Perform the decryption using the private key
    openssl pkeyutl -decrypt -inkey "$PRIV_KEY" -in "$file" -out "$output_file"

    if [ $? -eq 0 ]; then
        echo "Success: $output_file created."
    else
        echo "Error: Failed to decrypt $file."
    fi
done

echo "Batch decryption complete."
