FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y gnupg

RUN echo deb http://package.perforce.com/apt/ubuntu bionic release> /etc/apt/sources.list.d/perforce.list
RUN wget -qO - https://package.perforce.com/perforce.pubkey | apt-key add -

RUN apt-get update
RUN apt-get install -y helix-p4d
RUN apt-get install -y helix-cli

EXPOSE 1666

ENV P4NAME p4
ENV P4PORT 1666
ENV P4USER p4admin
ENV P4PASSWD p4admin@12345
ENV P4LOG /p4d/logs
ENV P4JOURNAL /p4d/journals

RUN mkdir -p $P4LOG/log && \
    mkdir -p $P4JOURNAL

WORKDIR /p4d/
VOLUME /p4d
#VOLUME /opt/perforce/servers
#VOLUME /opt/perforce/triggers
#VOLUME /etc/perforce

ADD ./run.sh /
CMD ["/run.sh"]
