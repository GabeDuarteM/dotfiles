#!/bin/bash

function unzip-all {

  # Check if a file is provided
  if [ -z "$1" ]; then
    echo "Usage: $0 <file>"
    exit 1
  fi

  # Get the file extension
  file=$1
  extension="${file##*.}"

  # Extract based on file extension
  case "$extension" in
  zip)
    unzip "$file"
    ;;
  tar)
    tar -xvf "$file"
    ;;
  gz)
    tar -xvzf "$file"
    ;;
  bz2)
    tar -xvjf "$file"
    ;;
  xz)
    tar -xvJf "$file"
    ;;
  *)
    echo "Unsupported file extension: $extension"
    exit 1
    ;;
  esac
}
