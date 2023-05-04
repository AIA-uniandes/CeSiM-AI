#!/bin/bash
set -eu

git clone https://github.com/AIA-uniandes/CeSiM-AI.git
echo 'cesim-ai' | sudo chown cesim-ai /dev/gpiomem


if [ -f "./CeSiM-AI/setup/bandas_setup.sh" ]; then
    ./CeSiM-AI/setup/bandas_setup.sh
else
    echo "File not found: ./CeSiM-AI/setup/bandas_setup.sh"
fi

exec "$@"
