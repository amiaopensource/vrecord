#!/bin/bash

# vplay: a script to play back digitized video files with vrecord visualizations

# Ensure a file is passed as an argument
if [ -z "$1" ]; then
  echo "Usage: vplay [video file]"
  exit 1
fi

# Path to the Lua script
RESOURCE_PATH="$(dirname "$0")/Resources"
LUA_SCRIPT="${RESOURCE_PATH}/qcview.lua"

# Check if the file exists
VIDEO_FILE="$1"
if [ ! -f "$VIDEO_FILE" ]; then
  echo "Error: File '$VIDEO_FILE' not found."
  exit 1
fi

# Check if mpv is installed
if ! command -v mpv &> /dev/null; then
  echo "Error: mpv is not installed. Please install mpv."
  exit 1
fi

# mpv options
MPVOPTS=(--no-osc)
MPVOPTS+=(--load-scripts=no)
MPVOPTS+=(--script="$LUA_SCRIPT")
MPVOPTS+=(--really-quiet)
MPVOPTS+=(--title="vplay - $(basename "$VIDEO_FILE")")

# Play the file with visualizations
mpv "${MPVOPTS[@]}" "$VIDEO_FILE"
