FROM debian:9

# Needed for X11 forwarding
ENV DISPLAY :0

# Needed for X11 forwarding
ENV USERNAME developer

WORKDIR /app

RUN apt update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-transport-https \
    software-properties-common 

# Add helix repository
RUN add-apt-repository ppa:maveonair/helix-editor

RUN apt update

# install helix
RUN DEBIAN_FRONTEND=noninteractive apt install -yq helix

# create and switch to a user
RUN echo "backus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN adduser $USERNAME root

USER $USERNAME

WORKDIR /home/$USERNAME

CMD "hx"