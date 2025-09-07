FROM python:3.9-slim-bullseye

# Install required system packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ffmpeg \
 && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip \
 && pip install -U -r /requirements.txt

# Set working directory
WORKDIR /MusicPlayer
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Run the bot
CMD ["/bin/bash", "/startup.sh"]
