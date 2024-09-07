FROM kalilinux/kali-rolling:latest
LABEL maintainer="lucas.mullers@gmail.com"
RUN apt update && \
    apt -y upgrade && \
    apt -y install ca-certificates
RUN DEBIAN_FRONTEND=noninteractive apt -y full-upgrade && \
    apt -yq install \
    kali-linux-arm \
    kali-desktop-xfce \
    xfce4-goodies
RUN DEBIAN_FRONTEND=noninteractive apt -yq install \
    openssh-server \
    python3 \
    dialog \
    firefox-esr \
    inetutils-ping \
    htop \
    nano \
    net-tools \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    tigervnc-viewer \
    novnc \
    dbus-x11 \
    kali-tools-fuzzing \
    kali-tools-information-gathering \
    kali-tools-vulnerability \
    kali-tools-web \
    kali-tools-database \
    kali-tools-passwords \
    kali-tools-exploitation \
    kali-tools-sniffing-spoofing \
    ffuf \
    burpsuite \
    gobuster
RUN apt -y autoremove && \
    apt clean all && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i "s/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g" /etc/ssh/sshd_config && \
    sed -i "s/off/remote/g" /usr/share/novnc/app/ui.js && \
    mkdir -p /dev/net && \
    mknod /dev/net/tun c 10 200 && \
    chmod 600 /dev/net/tun && \
    /etc/init.d/openvpn restart && \
    # useradd -m -c "Kali Linux" -s /bin/bash -d /home/kali kali && \
    # echo "kali ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    touch /usr/share/novnc/index.htm && \
    gzip -d /usr/share/wordlists/rockyou.txt.gz
COPY startup.sh /startup.sh
WORKDIR /root/kali
# ENV PASSWORD=kali
# ENV SHELL=/bin/bash
EXPOSE 8080
ENTRYPOINT ["/bin/bash", "/startup.sh"]