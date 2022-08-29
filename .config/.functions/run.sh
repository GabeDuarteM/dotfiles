#!/bin/sh

run() {
  if [ -f "Cargo.toml" ]; then
    cargo run
    return
  elif [ -f "package.json" ]; then
    npm run start
    return
  elif [ -f "go.mod" ]; then
    go run .
    return
  else
    echo "No build script found"
    return
  fi
}
