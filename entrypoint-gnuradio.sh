#!/bin/bash
set -e

export PATH="/app/radioconda/bin:$PATH"

if command -v gnuradio-companion >/dev/null; then
    echo "GNU Radio is installed ✅"
else
    echo "GNU Radio is NOT installed ❌"
fi

exec tail -f /dev/null

