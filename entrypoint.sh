#!/bin/bash

# Prettify references once at start
if [ -f "bibtex_prettifier.rb" ] && [ -f "references.bib" ]; then
    echo "Prettifying references.bib..."
    ruby bibtex_prettifier.rb
fi

# Run latexmk in preview mode (pvc)
# -pdf: Generate PDF
# -pvc: Preview Continuous mode (watch for changes)
# -interaction=nonstopmode: Don't stop for errors
# -cd: Change directory to the file location (if needed)

# Find the main tex file
MAIN_TEX=$(ls *.tex | head -n 1)

if [ -z "$MAIN_TEX" ]; then
    echo "No .tex file found!"
    exit 1
fi

echo "Starting latexmk -pvc on $MAIN_TEX..."
exec latexmk -pdf -pvc -view=none -interaction=nonstopmode "$MAIN_TEX"
