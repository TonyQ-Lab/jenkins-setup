#!/bin/bash

set -euxo pipefail

PLUGINS_DIR="/home/ubuntu/.jenkins/plugins"
OUTPUT_FILE="plugins.txt"

# Ensure the plugins directory exists
if [ ! -d "$PLUGINS_DIR" ]; then
    echo "ERROR: Plugins directory not found at $PLUGINS_DIR"
    exit 1
fi

echo "Exporting Jenkins plugins from $PLUGINS_DIR to $OUTPUT_FILE..."

# Empty the output file
> "$OUTPUT_FILE"

# Loop through each plugin directory or .jpi/.hpi file
for plugin_path in "$PLUGINS_DIR"/*; do
    # Handle both exploded plugin dirs and single-file .jpi/.hpi
    if [ -d "$plugin_path" ]; then
        manifest="$plugin_path/META-INF/MANIFEST.MF"
    elif [[ "$plugin_path" =~ \.(jpi|hpi)$ ]]; then
        manifest=$(mktemp)
        unzip -qq -p "$plugin_path" META-INF/MANIFEST.MF > "$manifest"
    else
        continue
    fi

    # Extract plugin name and version
    name=$(basename "$plugin_path" | sed 's/\.[^/.]*$//')
    version=$(grep "^Plugin-Version" "$manifest" | cut -d: -f2 | xargs)

    # Save to output if version found
    if [ -n "$version" ]; then
        echo "${name}:${version}" >> "$OUTPUT_FILE"
    fi

    # Cleanup temp manifest if created
    if [[ "$plugin_path" =~ \.(jpi|hpi)$ ]]; then
        rm -f "$manifest"
    fi
done

echo "Done! Plugin list saved to $OUTPUT_FILE"