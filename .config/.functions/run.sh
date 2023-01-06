#!/bin/sh

run () {
  # Store the arguments in a variable
  args=$@

  if [ -f "Cargo.toml" ]
  then
    cargo run $args
    return
  elif [ -f "pnpm-lock.yaml" ]
  then
    pnpm start $args
    return
  elif [ -f "yarn.lock" ]
  then
    yarn start $args
    return
  elif [ -f "package.json" ]
  then
    npm run start $args
    return
  elif [ -f "go.mod" ]
  then
    go run . $args
    return
  else
    echo "No build script found"
    return
  fi
}
