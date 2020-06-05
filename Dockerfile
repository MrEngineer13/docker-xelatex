# Installs Xelatex and all Google Web Fonts. A curated selection of the finest
# open fonts.

FROM ubuntu:latest
# Installs Tzdata before dependencies
RUN export DEBIAN_FRONTEND=noninteractive; \
    export DEBCONF_NONINTERACTIVE_SEEN=true; \
    echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections; \
    echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections; \
    apt-get update -qqy \
 && apt-get install -qqy --no-install-recommends \
        tzdata
        
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
  curl \
  wget \
  awscli

# Install the Dropbox-Uploader package which includes the Dropbox-uploader executable.
RUN git clone https://github.com/andreafabrizi/Dropbox-Uploader.git
WORKDIR ./Dropbox-Uploader
RUN touch ./.dropbox_uploader
RUN chmod +x ./dropbox_uploader.sh

RUN  apt-get autoclean && apt-get --purge --yes autoremove && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Export the output data
WORKDIR /Dropbox-Uploader
VOLUME ["/Dropbox-Uploader"]
