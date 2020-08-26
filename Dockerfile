FROM debian:buster as build

# install build dependencies
RUN set -xe \
    && apt-get update \
    && apt-get install -y \
        gnupg wget lzop \
        libaio1 librbd1 glusterfs-common libiscsi-bin libcurl4-gnutls-dev libjemalloc2 \
        libglib2.0-0

# add proxmox repository and download vma tool
RUN set -xe \
    && echo deb "http://download.proxmox.com/debian buster pve-no-subscription" >> /etc/apt/sources.list \
    && wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox.gpg \
    && apt-get update \
    && apt-get install -y \
        libproxmox-backup-qemu0 \
    && apt-get download pve-qemu-kvm \
    && dpkg --fsys-tarfile ./pve-qemu-kvm_* | tar xOf - ./usr/bin/vma > /usr/bin/vma \
    && chmod 0755 /usr/bin/vma

ENTRYPOINT [ "/bin/bash" ]