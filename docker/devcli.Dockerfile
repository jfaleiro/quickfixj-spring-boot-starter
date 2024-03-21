# pasted from https://github.com/jfaleiro/container-devcli/blob/v0.1.5/Dockerfile

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get clean \
    && apt-get update \
    && apt-get install --no-install-recommends -y \
        zsh \
        graphviz \
        gh \
        openssh-client \
        rename \
        xclip \
    && echo "cleaning up..." \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# see https://github.com/ohmyzsh/ohmyzsh/wiki
# RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ENV DEBIAN_FRONTEND=dialog \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8