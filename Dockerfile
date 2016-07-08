FROM java:openjdk-8
MAINTAINER "Ocasta Studios <info@ocasta.com>"

ADD slamdata.sh slamdata.sh
RUN chmod +x slamdata.sh && \
    bash -c "./slamdata.sh <<< $'o\n/usr/local/slamdata\ny\n\n'"
ADD quasar-config.json /root/.config/quasar/quasar-config.json

VOLUME /slamdata
ENTRYPOINT ["/usr/local/bin/SlamData"]
