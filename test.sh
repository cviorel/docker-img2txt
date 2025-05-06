#!/bin/bash

# Create necessary directories
mkdir -p samples
mkdir -p output

echo "Building Docker image..."
docker build -t img2txt .

echo "Testing the Docker container..."
echo "Note: You need to have an image file in the samples directory to test."
echo "Example: Place an image file named 'sample.jpg' in the samples directory."
echo ""
echo "To test with your own image, run:"
echo "docker run --rm -v $(pwd)/samples:/images img2txt /images/your-image.jpg"
echo ""
echo "To test and save the output to a file, run:"
echo "docker run --rm -v $(pwd)/samples:/images -v $(pwd)/output:/output img2txt /images/your-image.jpg /output/result"
echo ""
echo "The extracted text will be saved to output/result.txt"
