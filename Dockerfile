# Installs Xelatex and all Google Web Fonts. A curated selection of the finest
# open fonts.

FROM ubuntu:latest

RUN echo "deb http://us.archive.ubuntu.com/ubuntu/ precise universe" >> /etc/apt/sources.list
RUN apt-get update && \
  apt-get install --yes --no-install-recommends \
  make \
  git \
  openssh-client \
  ca-certificates \
  lmodern \
  texlive-full \
  python3-pip \
  fonts-font-awesome \
  awscli && \
  curl && \ 
  wget

# Install the Dropbox-Uploader package which includes the Dropbox-uploader executable.
RUN git clone clone https://github.com/andreafabrizi/Dropbox-Uploader.git
RUN cd ./Dropbox-Uploader
RUN touch ./.dropbox_uploader
RUN chmod +x dropbox_uploader.sh

RUN  apt-get autoclean && apt-get --purge --yes autoremove && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Export the output data
WORKDIR /Dropbox-Uploader
VOLUME ["/Dropbox-Uploader"]
