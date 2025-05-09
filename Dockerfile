# Set default version if not provided
ARG RELEASE_VERSION=2025.03.14
FROM python:3.11-slim

# Set ARG again after FROM to ensure it's available
ARG RELEASE_VERSION

# Install necessary packages
RUN apt-get update && apt-get install -y \
    bash wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# If  you have downloaded any version of radioconda you wanna use here, just rename the script as radioconda.sh and copy with the line below
#COPY radioconda.sh /tmp/radioconda.sh

# Download Radioconda release with error handling, modify the argument RELEASE_VERSION to change the default
RUN set -e && \
    echo "Downloading Radioconda version: $RELEASE_VERSION" && \
    DOWNLOAD_URL="https://github.com/ryanvolz/radioconda/releases/download/$RELEASE_VERSION/radioconda-$RELEASE_VERSION-Linux-x86_64.sh" && \
    wget -O /tmp/radioconda.sh "$DOWNLOAD_URL" \
    grep -q 'bash' /tmp/radioconda.sh || { echo "Download failed. Check if the version exists."; exit 1; } && \
    chmod +x /tmp/radioconda.sh && \
    /tmp/radioconda.sh -b -p /app/radioconda

# Optional: Add Radioconda to PATH
ENV PATH="/app/radioconda/bin:$PATH"

# Optional: Copy environment file
# COPY radioconda.yml .

# GNU RADIO GUI launcher script
COPY gnuradio.sh /gnuradio.sh
# Optional: Set entrypoint/entrypoint script
#COPY entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]
# ENTRYPOINT ["python", "-m", "radioconda.cli", "--config", "radioconda.yml"]
