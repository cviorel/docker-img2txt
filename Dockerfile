FROM alpine:3.19

# Install Tesseract OCR and required dependencies
RUN apk update && \
    apk add --no-cache \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    tesseract-ocr-data-fra \
    tesseract-ocr-data-deu \
    tesseract-ocr-data-nld \
    # Add more language packs as needed: https://tesseract-ocr.github.io/tessdoc/Data-Files-in-different-versions.html
    bash

# Create a working directory
WORKDIR /app

# Copy the script to the container
COPY extract_text.sh /app/
RUN chmod +x /app/extract_text.sh

# Set the entrypoint
ENTRYPOINT ["/app/extract_text.sh"]
