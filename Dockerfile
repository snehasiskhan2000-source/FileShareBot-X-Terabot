# Use a standard, lightweight Python image
FROM python:3.10-slim

# Install FFmpeg for video processing
RUN apt-get update && apt-get install -y ffmpeg

WORKDIR /app

# Copy requirements first
COPY requirements.txt .

# Install your Python packages 
RUN pip install --no-cache-dir -r requirements.txt

# Download the exact browser version for network sniffing
RUN playwright install chromium

# Install the necessary system dependencies for the browser
RUN playwright install-deps

# Copy your bot code
COPY . .

# Starts FileShareBot, waits 3 seconds, THEN starts TeraboxBot.
CMD bash -c "python main.py & sleep 3 && python terabox.py"
