#!/bin/bash
set -e

# Get the directory where the whisper repo is located
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Starting whisper.cpp server installation..."

# Install ffmpeg if not installed
if ! command -v ffmpeg &> /dev/null; then
    echo "ffmpeg not found. Installing via Homebrew..."
    if ! command -v brew &> /dev/null; then
        echo "Homebrew must be installed first! Visit https://brew.sh to install it."
        exit 1
    fi
    brew install ffmpeg
else
    echo "ffmpeg is already installed!"
fi

# Build whisper
echo "Compiling whisper.cpp and whisper-server..."
cd "$REPO_DIR"
make -j4

# Download model
echo "Downloading the large-v3-turbo model..."
bash ./models/download-ggml-model.sh large-v3-turbo

# Create shortcuts on Desktop
echo "Creating start and stop shortcuts on your Desktop..."

cat << EOF > ~/Desktop/start_whisper_server.command
#!/bin/bash
cd "$REPO_DIR"
nohup ./build/bin/whisper-server -m models/ggml-large-v3-turbo.bin --port 8080 --convert > whisper.log 2>&1 &
echo "Whisper server started in the background on port 8080!"
sleep 2
EOF

cat << EOF > ~/Desktop/stop_whisper_server.command
#!/bin/bash
killall whisper-server
echo "Whisper server stopped!"
sleep 2
EOF

chmod +x ~/Desktop/start_whisper_server.command
chmod +x ~/Desktop/stop_whisper_server.command

echo ""
echo "=========================================="
echo "Installation complete!"
echo "You can now double-click 'start_whisper_server.command' on your Desktop to start the transcription server."
echo "=========================================="
sleep 3
