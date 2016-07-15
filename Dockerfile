FROM java:openjdk-8
MAINTAINER "Ocasta Studios <info@ocasta.com>"

ADD run.sh /run.sh
RUN cd / && wget -q https://github.com/slamdata/slamdata/releases/download/v3.0.1/slamdata.tar.bz2 && \
    tar xjf slamdata.tar.bz2 && rm slamdata.tar.bz2 && \
    mkdir -p /root/.config/quasar/ && \
    chmod a+x /run.sh

CMD . /run.sh
