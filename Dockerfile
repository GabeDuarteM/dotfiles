FROM ubuntu

# Add sudo
RUN apt-get update
RUN apt-get install sudo
# Add the apt packages to speed up the process of the script
RUN sudo apt-get install build-essential curl file git snapd -y

# Create the user with sudo capabilities, and use it
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN sudo usermod -a -G root docker
USER docker

# Set the env 'user', so that brew can be installed
ENV USER docker

COPY . /home/docker/Projects/dotfiles

RUN bash /home/docker/Projects/dotfiles/setup.sh -g

ENTRYPOINT /home/linuxbrew/.linuxbrew/bin/zsh
