# Docker Image to Text (img2txt)

A Docker container that uses Tesseract OCR to extract text from images. This tool makes it easy to perform Optical Character Recognition (OCR) on various image formats without installing Tesseract and its dependencies directly on your system.

[![Build and Publish Docker Image](https://github.com/yourusername/docker-img2txt/actions/workflows/docker-build.yml/badge.svg)](https://github.com/yourusername/docker-img2txt/actions/workflows/docker-build.yml)

## Features

- Extract text from various image formats (JPG, PNG, TIFF, BMP, GIF, WebP)
- Output text to stdout or to a file
- Multi-language support (English, French, German, Dutch included by default)
- Easy to use with simple Docker commands
- Based on Tesseract OCR, a powerful open-source OCR engine
- Alpine-based container for minimal size

## Prerequisites

- Docker installed on your system

## Building the Docker Image

Clone this repository and build the Docker image:

```bash
git clone https://github.com/yourusername/docker-img2txt.git
cd docker-img2txt
docker build -t img2txt .
```

Alternatively, you can use the provided scripts which will create the necessary directories and build the image:

- On Linux/macOS: `./test.sh`
- On Windows: `.\test.ps1`

## Usage

### Basic Usage

Extract text from an image and display it in the terminal:

```bash
docker run --rm -v /path/to/your/images:/images img2txt /images/your-image.jpg
```

### Save Output to a File

Extract text from an image and save it to a file:

```bash
docker run --rm -v /path/to/your/images:/images -v /path/to/output:/output img2txt /images/your-image.jpg /output/result
```

The extracted text will be saved to `/path/to/output/result.txt`.

## Examples

### Example 1: Extract text from a JPG image

Linux/macOS:

```bash
docker run --rm -v $(pwd)/samples:/images img2txt /images/sample.jpg
```

Windows (PowerShell):

```powershell
docker run --rm -v ${PWD}\samples:/images img2txt /images/sample.jpg
```

### Example 2: Extract text and save to a file

Linux/macOS:

```bash
docker run --rm -v $(pwd)/samples:/images -v $(pwd)/output:/output img2txt /images/sample.jpg /output/sample_text
```

Windows (PowerShell):

```powershell
docker run --rm -v ${PWD}\samples:/images -v ${PWD}\output:/output img2txt /images/sample.jpg /output/sample_text
```

## Project Structure

- `extract_text.sh`: The main script that handles the OCR process
- `Dockerfile`: Defines the Docker image with Tesseract OCR and required dependencies
- `test.sh` / `test.ps1`: Helper scripts for building and testing the container
- `.github/workflows/`: GitHub Actions workflow files for CI/CD
- `samples/`: Directory for storing test images
- `output/`: Directory for storing extracted text files

## GitHub Actions CI/CD Pipeline

This project includes GitHub Actions workflows for continuous integration and delivery:

### Automated Docker Image Building and Publishing

The project is configured with GitHub Actions to automatically build and publish the Docker image to GitHub Container Registry (GHCR) when:

- Code is pushed to the main/master branch
- A new tag with format `v*` is created (e.g., v1.0.0)
- Manually triggered via the GitHub Actions interface

The published images can be found at: `ghcr.io/yourusername/docker-img2txt`

### Using the Published Image

Once the image is published, you can use it directly without building it locally:

```bash
docker pull ghcr.io/yourusername/docker-img2txt:latest
docker run --rm -v /path/to/your/images:/images ghcr.io/yourusername/docker-img2txt:latest /images/your-image.jpg
```

### Versioning

The CI/CD pipeline automatically tags the Docker images based on:

- Git tags (e.g., v1.0.0)
- Major.Minor versions (e.g., 1.0)
- Branch name
- Commit SHA
- Latest tag for the default branch

### Automated Testing

Pull requests to the main/master branch trigger a test workflow that:

1. Builds the Docker image
2. Creates a test image with known text
3. Runs the OCR process on the test image
4. Verifies the extracted text matches the expected output

## Supported Languages

The Docker image comes with the following language support by default:

- English (eng)
- French (fra)
- German (deu)
- Dutch (nld)

## Adding Additional Languages

If you need additional languages, modify the Dockerfile to include the required language packs:

```dockerfile
RUN apk update && \
    apk add --no-cache \
    tesseract-ocr \
    tesseract-ocr-data-eng \
    tesseract-ocr-data-fra \
    tesseract-ocr-data-deu \
    tesseract-ocr-data-nld \
    tesseract-ocr-data-spa \  # Spanish
    tesseract-ocr-data-ita \  # Italian
    # Add more language packs as needed
    bash
```

For a complete list of available language packs, refer to the [Tesseract documentation](https://tesseract-ocr.github.io/tessdoc/Data-Files-in-different-versions.html).

## Troubleshooting

If you encounter issues with the OCR process:

1. Ensure your image is high quality with clear text
2. Check that the image format is supported
3. Verify that the language of the text in your image is included in the Docker image

### Debug Messages

By default, the script suppresses Tesseract's debug messages (like "Estimating resolution as...") by redirecting stderr to /dev/null. If you need to see these messages for troubleshooting purposes, you can modify the `extract_text.sh` script by removing the `2>/dev/null` redirections.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
