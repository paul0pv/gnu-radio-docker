#!/bin/bash
set -e

# Activate Radioconda environment (micromamba or source conda.sh)
if [ -f /app/radioconda/etc/profile.d/conda.sh ]; then
  echo "Activating Radioconda environment..."
  source /app/radioconda/etc/profile.d/conda.sh
  conda activate
else
  echo "conda.sh not found, trying micromamba..."
  export PATH="/app/radioconda/bin:$PATH"
  micromamba shell init -s bash -p /app/radioconda
  eval "$(micromamba shell hook -s bash)"
  micromamba activate /app/radioconda
fi

# Keep the container alive for manual testing
echo "Container started. Radioconda environment should be active."
exec tail -f /dev/null

