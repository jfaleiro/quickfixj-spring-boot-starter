# syntax = devthefuture/dockerfile-x
# support for include - see https://github.com/moby/moby/issues/735#issuecomment-1703847889
FROM jfaleiro/build:v0.1.2

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y install --no-install-recommends \
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
# SHELL ["/usr/bin/zsh", "-c"]

# Install SDKMAN
ENV SDKMAN_DIR=${HOME}/.sdkman
RUN curl -s "https://get.sdkman.io" | bash

# Install JAVA
# Eclipse Temurin is the name of the OpenJDK distribution from Adoptium - Formerly AdoptOpenJDK∏
RUN . "$SDKMAN_DIR/bin/sdkman-init.sh" \
    && sdk install java 11.0.22-tem 

# Install MAVEN
RUN . "$SDKMAN_DIR/bin/sdkman-init.sh" \
    && sdk install maven

# Install gradle
RUN . "$SDKMAN_DIR/bin/sdkman-init.sh" \
    && sdk install gradle

# INCLUDE https://github.com/jfaleiro/container-devcli/blob/v0.1.5/Dockerfile
INCLUDE devcli.Dockerfile

# Required for sdk on zsh - see https://github.com/sdkman/sdkman-cli/issues/613#issuecomment-696557301
RUN echo '# SDKMAN!' >> "$HOME/.zshrc"
RUN echo 'source "$SDKMAN_DIR/bin/sdkman-init.sh"' >> "$HOME/.zshrc"
RUN cat "$HOME/.zshrc"
