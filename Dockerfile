FROM openjdk:8
MAINTAINER "Ocasta Studios <info@ocasta.com>"

ENV SLAM_VERSION="4.2.4"
RUN wget -q -O slamdata.tar.bz2 https://github.com/slamdata/slamdata/releases/download/v${SLAM_VERSION}/slamdata.tar.bz2
RUN mkdir slamdata && tar -xjvf  slamdata.tar.bz2 -C slamdata --strip-components=1 && rm slamdata.tar.bz2
RUN mkdir -p /root/.config/quasar/

ENV QUASAR_VERSION="18.7.4"
RUN cd slamdata && \
    wget -O quasar.jar -q https://github.com/quasar-analytics/quasar/releases/download/v${QUASAR_VERSION}/quasar-web-assembly-${QUASAR_VERSION}.jar && \
    wget -O quasar-repl.jar -q https://github.com/quasar-analytics/quasar/releases/download/v${QUASAR_VERSION}/quasar-repl-assembly-${QUASAR_VERSION}.jar
ADD run.sh /run.sh
ADD run-advanced.sh /run-advanced.sh
RUN chmod a+x /run.sh && chmod a+x /run-advanced.sh

CMD . /run.sh
