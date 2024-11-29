FROM ubuntu:oracular

MAINTAINER NJD <mail@maxmatveev.com>

ARG DEBIAN_FRONTEND=noninteractive

LABEL Description="ISC DHCP server v6" \
        tags="" \
        maintainer="zlowred <https://github.com/zlowred>" \
        build_ver="202411290000"

RUN apt-get -q -y update \
 && apt-get -q -y install dumb-init \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install apt-utils \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" dist-upgrade \
 && apt-get -q -y -o "DPkg::Options::=--force-confold" -o "DPkg::Options::=--force-confdef" install isc-dhcp-server man \
 && apt-get -q -y autoremove \
 && apt-get -q -y clean \
 && rm -rf /var/lib/apt/lists/*


#COPY util/dumb-init_1.2.5_x86_64 /usr/bin/dumb-init
COPY util/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
