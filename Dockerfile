FROM java:openjdk-8
MAINTAINER "Ocasta Studios <info@ocasta.com>"

ENV QUASAR_VERSION="12.4.23"
ENV SLAM_VERSION="4.0.0"
ADD run.sh /run.sh
ADD run-advanced.sh /run-advanced.sh
RUN apt-get update && apt-get upgrade -y && \
    wget -q https://nodejs.org/dist/v4.6.0/node-v4.6.0-linux-x64.tar.xz && \
    tar -C /usr/local --strip-components 1 -xJf node-v4.6.0-linux-x64.tar.xz && npm install bower -g && \
    wget -q -O slamdata.tar.gz https://github.com/slamdata/slamdata/archive/v${SLAM_VERSION}.tar.gz && \
    mkdir slamdata && tar -xzf  slamdata.tar.gz -C slamdata --strip-components=1 && \
    rm slamdata.tar.gz && rm node-v4.6.0-linux-x64.tar.xz && cd slamdata && \
    bower --allow-root install && npm install && npm run build && \
    apt-get -y remove npm && apt-get -y autoremove && apt-get clean && \
    mkdir -p /root/.config/quasar/ && \
    wget -O quasar.jar -q https://github.com/quasar-analytics/quasar/releases/download/v${QUASAR_VERSION}-quasar-web/quasar-web-assembly-${QUASAR_VERSION}.jar && \
    wget -O quasar-repl.jar -q https://github.com/quasar-analytics/quasar/releases/download/v${QUASAR_VERSION}-quasar-repl/quasar-repl-assembly-${QUASAR_VERSION}.jar && \
    chmod a+x /run.sh && chmod a+x /run-advanced.sh

CMD . /run.sh
