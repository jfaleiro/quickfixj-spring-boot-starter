# syntax = devthefuture/dockerfile-x
# support for include - see https://github.com/moby/moby/issues/735#issuecomment-1703847889
FROM jfaleiro/build:v0.1.2

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
        graphviz \
        python3-pip \
        pipx \
        curl \
        unzip \
        zip \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Pre-commit
RUN pipx install pre-commit \
    && pipx ensurepath

# Required for sdk to work properly (source ...)
SHELL ["/bin/bash", "-c"]

# Install SDKMAN
RUN curl -s "https://get.sdkman.io" | bash

# Install JAVA
RUN . "$HOME/.sdkman/bin/sdkman-init.sh" \
    && sdk install java

# Install MAVEN
RUN . "$HOME/.sdkman/bin/sdkman-init.sh" \
    && sdk install maven

# Install gradle
RUN . "$HOME/.sdkman/bin/sdkman-init.sh" \
    && sdk install gradle

# INCLUDE https://github.com/jfaleiro/container-devcli/blob/v0.1.5/Dockerfile
INCLUDE devcli.Dockerfile
