#!/bin/bash
set -eu

git clone https://github.com/AIA-uniandes/CeSiM-AI.git

if [ -f "./CeSiM-AI/install/base_install.sh" ]; then
    ./CeSiM-AI/install/base_install.sh
else
    echo "File not found: ./CeSiM-AI/install/base_install.sh"
fi

exec "$@"
