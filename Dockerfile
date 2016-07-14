FROM java:openjdk-8
MAINTAINER "Ocasta Studios <info@ocasta.com>"


RUN cd / && wget -q https://github.com/slamdata/slamdata/releases/download/v3.0.1/slamdata.tar.bz2 && \
    tar xjf slamdata.tar.bz2 && rm slamdata.tar.bz2
ADD quasar-config.json /root/.config/quasar/quasar-config.json

CMD java -jar /slamdata/quasar.jar --content-path /slamdata/public
