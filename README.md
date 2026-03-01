# Meditalks Whisper Server for Mac

This is a custom-configured version of whisper.cpp designed to be **extremely easy to install and run** on a Mac. 
It runs a local, privacy-first transcription server with an OpenAI-compatible API and features automatic audio conversion for formats like `.mp3`, `.webm`, `.mp4`, and `.m4a`.

## 🚀 One-Click Installation 

1. Open your **Terminal** app on your Mac.
2. Copy and paste the following commands to download and install:
   ```bash
   git clone https://github.com/miltosdoc/meditalkswhispermac.git
   cd meditalkswhispermac
   ./install-server.command
   ```
3. The installer will automatically do everything for you:
   * Install `ffmpeg` (required for converting audio/video files).
   * Compile the whisper transcription server.
   * Download the highly-accurate `large-v3-turbo` model.
   * Create **Start** and **Stop** shortcuts directly on your Mac's Desktop!

## 🎧 Running the Server

Once installed, you don't need to use the terminal to start it. Simply go to your Mac's **Desktop** and double-click:
* 🟢 **`start_whisper_server.command`** - Starts the server silently in the background.
* 🔴 **`stop_whisper_server.command`** - Shuts down the server.

The server will run locally at `http://127.0.0.1:8080`.

## 💻 How to Transcribe Audio

With the server running, you can send any audio or video file to it. It will automatically detect the language and transcribe it.

Open your Terminal and run:

```bash
curl 127.0.0.1:8080/inference \
  -H "Content-Type: multipart/form-data" \
  -F file="@./path/to/your/audio.mp3" \
  -F language="auto" \
  -F request="{ \"type\" : \"transcription\"}"
```

*(Just make sure to replace `./path/to/your/audio.mp3` with the actual path to your file!)*

---
*For advanced configuration, developer instructions, and the original whisper.cpp documentation, please see [README-original.md](README-original.md).*
