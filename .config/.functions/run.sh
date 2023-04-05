#!/bin/zsh

run () {
  # Store the arguments in a variable
  args=$@

  script="start"

  if [ -n "$(find . -maxdepth 1 -type f -name 'next.config.*')" ]; then
    script="dev"
  elif [ -n "$(find . -maxdepth 1 -type f -name 'astro.config.*')" ]; then
    script="dev"
  fi

  if [ -f "Cargo.toml" ]
  then
    cargo run $args
    return
  elif [ -f "pnpm-lock.yaml" ]
  then
    pnpm $script $args
    return
  elif [ -f "yarn.lock" ]
  then
    yarn $script $args
    return
  elif [ -f "package.json" ]
  then
    npm run $script $args
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
