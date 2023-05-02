#!/bin/bash
set -eu

echo 'cesim-ai' | sudo -S chown cesim-ai:video /dev/video0
git clone https://github.com/AIA-uniandes/CeSiM-AI.git

if [ -f "./CeSiM-AI/setup/vision_setup.sh" ]; then
    ./CeSiM-AI/setup/vision_setup.sh
else
    echo "File not found: ./CeSiM-AI/setup/vision_setup.sh"
fi

exec "$@"
