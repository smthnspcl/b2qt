FROM ubuntu:bionic

RUN apt-get update && \
    apt-get install -y gawk curl git-core git-lfs diffstat unzip texinfo build-essential locales repo \
                       chrpath libsdl1.2-dev xterm gperf bison gcc-multilib g++-multilib wget cpio sudo && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

ENV LANG en_US.utf8

RUN useradd builder -m && \
    adduser builder sudo && \
    echo "\nbuilder ALL=(ALL) NOPASSWD: ALL\n" > /etc/sudoers && \
    chown builder -R /home/builder

ADD build/build.sh /home/builder/build.sh

USER builder

ENTRYPOINT ["/home/builder/build.sh"]
