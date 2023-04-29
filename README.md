# dotfiles

## Setup

1. run `curl -L https://gdm.dev/dotfiles | bash`

## Dev

To test the environment more easily, you can use the following Dockerfile

```Dockerfile
FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y \
    sudo

# adds a user with sudo privileges and sets an ultra-secure highly classified password
RUN useradd -m gabe && echo "gabe:gabe" | chpasswd && adduser gabe sudo

USER gabe

WORKDIR /home/gabe

COPY . .
```

And then run it with `docker build -t dotfiles . && docker run --rm -it dotfiles`

## See also

- [Useful commands](Useful%20commands.md)
