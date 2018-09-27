FROM  jenkins

#1 Install docker
RUN sudo apt-get update             && \
    sudo apt-get install -y            \
        apt-transport-https            \
        ca-certificates                \
        curl                           \
        gnupg2                         \
        software-properties-common

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

RUN sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/debian \
        $(lsb_release -cs) \
        stable"

RUN sudo apt-get update
RUN sudo apt-get install docker-ce

# Install docker-machine
RUN base=https://github.com/docker/machine/releases/download/v0.14.0            && \
    curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine   && \
    install /tmp/docker-machine /usr/local/bin/docker-machine

# Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    sudo chmod +x /usr/local/bin/docker-compose

# Make a docker group
RUN sudo groupadd docker
RUN sudo usermod -aG docker $USER