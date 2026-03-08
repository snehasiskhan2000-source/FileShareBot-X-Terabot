# Use a lightweight Python image
FROM python:3.10-slim

# Install FFmpeg (The Media Engine)
RUN apt-get update && apt-get install -y ffmpeg

# Set up the working directory
WORKDIR /app

# Copy your files into the server
COPY . .

# Install your Python requirements
RUN pip install --no-cache-dir -r requirements.txt

# Hugging Face requires web servers to run on port 7860
ENV PORT=7860

# Force Python to show us errors instantly in the logs
ENV PYTHONUNBUFFERED=1

# --- THE FIX: Staggered Boot ---
# Starts FileShareBot, waits 3 seconds so the database is safely created, THEN starts TeraboxBot.
CMD bash -c "python main.py & sleep 3 && python terabox.py"
