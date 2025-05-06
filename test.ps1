# Create necessary directories
New-Item -ItemType Directory -Force -Path samples
New-Item -ItemType Directory -Force -Path output

Write-Host "Building Docker image..."
docker build -t img2txt .

Write-Host "Testing the Docker container..."
Write-Host "Note: You need to have an image file in the samples directory to test."
Write-Host "Example: Place an image file named 'sample.jpg' in the samples directory."
Write-Host ""
Write-Host "To test with your own image, run:"
Write-Host "docker run --rm -v ${PWD}\samples:/images img2txt /images/your-image.jpg"
Write-Host ""
Write-Host "To test and save the output to a file, run:"
Write-Host "docker run --rm -v ${PWD}\samples:/images -v ${PWD}\output:/output img2txt /images/your-image.jpg /output/result"
Write-Host ""
Write-Host "The extracted text will be saved to output/result.txt"
