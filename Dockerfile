FROM java:openjdk-8
MAINTAINER "Ocasta Studios <info@ocasta.com>"

ADD run.sh /run.sh
RUN apt-get update && apt-get -y install npm && npm install bower -g && \
    wget -q https://nodejs.org/dist/v4.4.4/node-v4.4.4-linux-x64.tar.xz && \
    tar -C /usr/local --strip-components 1 -xJf node-v4.4.4-linux-x64.tar.xz && \
    wget -q -O slamdata.tar.gz https://github.com/slamdata/slamdata/archive/v3.0.7.tar.gz && \
    mkdir slamdata && tar -xzf  slamdata.tar.gz -C slamdata --strip-components=1 && \
    rm slamdata.tar.gz && rm node-v4.4.4-linux-x64.tar.xz && cd slamdata && \
    bower --allow-root install && npm install && npm run build && \
    apt-get -y remove npm && apt-get -y autoremove && apt-get clean && \
    mkdir -p /root/.config/quasar/ && \
    wget -O quasar.jar -q https://github.com/quasar-analytics/quasar/releases/download/v11.0.10-quasar-web/quasar-web_2.11-11.0.10-one-jar.jar && \
    chmod a+x /run.sh

CMD . /run.sh
