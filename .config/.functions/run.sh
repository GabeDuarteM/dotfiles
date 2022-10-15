#!/bin/sh

run() {
  if [ -f "Cargo.toml" ]; then
    cargo run
    return
  elif [ -f "pnpm-lock.yaml" ]; then
    pnpm start
    return
  elif [ -f "yarn.lock" ]; then
    yarn start
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
