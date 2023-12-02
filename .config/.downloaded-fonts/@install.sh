#!/bin/bash

# Copy all files except "@install.sh"
shopt -s extglob
cp !("@install.sh") ~/.local/share/fonts

# Run fc-cache
fc-cache -frv
