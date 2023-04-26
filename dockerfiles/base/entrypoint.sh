#!/bin/bash
set -eu

git clone https://github.com/AIA-uniandes/CeSiM-AI.git

if [ -f "./CeSiM-AI/setup/base_setup.sh" ]; then
    ./CeSiM-AI/setup/base_setup.sh
else
    echo "File not found: ./CeSiM-AI/setup/base_setup.sh"
fi

exec "$@"
