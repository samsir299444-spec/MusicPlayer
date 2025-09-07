FROM python:3.9-slim-bullseye

# Suppress pip root warning
ENV PIP_ROOT_USER_ACTION=ignore

# Install required system packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ffmpeg \
 && rm -rf /var/lib/apt/lists/*

# Copy requirements and install Python dependencies
COPY requirements.txt /requirements.txt
RUN pip install --upgrade pip \
 && pip install pytgcalls==3.0.0.dev21 \
 && pip install -U -r /requirements.txt

# Set working directory
WORKDIR /MusicPlayer
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# Run the bot
CMD ["/bin/bash", "/startup.sh"]
