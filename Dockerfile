FROM debian:buster

MAINTAINER danielpmc, <danielpd93@gmail.com>

RUN apt update \
    && apt upgrade -y \
    && apt -y install curl software-properties-common locales git \
    && apt-get install -y default-jre \
    && useradd -d /home/container -m container \
    && apt-get update

    # Grant sudo permissions to container user for commands
RUN apt-get update && \
    apt-get -y install sudo

    # Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

    # NodeJS
RUN curl -sL https://deb.nodesource.com/setup_17.x | bash - \
    && apt -y install nodejs \
    && apt -y install ffmpeg \
    && apt -y install make \
    && apt -y install build-essential \
    && apt -y install wget \ 
    && apt -y install curl \
    && apt -y install pm2
    
# Install basic software support
RUN apt-get update && \
    apt-get install --yes software-properties-common
    
    # Python 2 & 3
RUN apt -y install python python-pip python3 python3-pip

    # Golang
RUN apt -y install golang

#Yarn and Pm2 support for AIO
RUN npm i -g yarn pm2

USER container
ENV  USER container
ENV  HOME /home/container

WORKDIR /home/container

RUN wget https://raw.githubusercontent.com/DanBot-Hosting/pterodactyl-eggs/aio/entrypoint.sh

CMD ["/bin/bash", "/entrypoint.sh"]
