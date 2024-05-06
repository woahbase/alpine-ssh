# syntax=docker/dockerfile:1
#
ARG IMAGEBASE=frommakefile
#
FROM ${IMAGEBASE}
#
RUN set -xe \
    && apk add --no-cache --purge -uU \
        openssh \
        openssl \
        # curl \
        # git \
        rsync \
        tmux \
        autossh \
        sshfs \
    && mkdir -p /defaults \
    && mv /etc/ssh/ssh_config /defaults/ssh_config.default \
    && mv /etc/ssh/sshd_config /defaults/sshd_config.default \
    && rm -rf /var/cache/apk/* /tmp/*
#
COPY root/ /
#
VOLUME /etc/ssh/ /home/${S6_USER:-alpine}/.ssh
#
EXPOSE 22
#
ENTRYPOINT ["/init"]
