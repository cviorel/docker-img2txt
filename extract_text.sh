#!/bin/bash

# Check if an image file is provided
if [ $# -eq 0 ]; then
    echo "Error: No image file provided."
    echo "Usage: docker run -v /path/to/images:/images img2txt /images/image.jpg [output_file]"
    exit 1
fi

IMAGE_FILE=$1
OUTPUT_FILE=$2

# Check if the image file exists
if [ ! -f "$IMAGE_FILE" ]; then
    echo "Error: Image file '$IMAGE_FILE' not found."
    exit 1
fi

# If output file is not specified, use stdout
if [ -z "$OUTPUT_FILE" ]; then
    # Run Tesseract OCR and output to stdout, suppress info messages
    tesseract "$IMAGE_FILE" stdout 2>/dev/null
else
    # Run Tesseract OCR and output to the specified file
    # Strip the extension if present
    OUTPUT_BASE="${OUTPUT_FILE%.*}"
    tesseract "$IMAGE_FILE" "$OUTPUT_BASE" 2>/dev/null
    echo "Text extracted to $OUTPUT_BASE.txt"
fi
